#!/usr/bin/env bash
# スキルを ~/.claude/skills/ にリンク（symlink）で入れる。
#
#   bash setup/install.sh            # 入れる（何度実行しても同じ結果）
#   bash setup/install.sh --check    # 入っているかを確かめるだけ（何も変えない）
#   bash setup/install.sh --uninstall  # このリポが張ったリンクだけを外す
#   bash setup/install.sh --copy     # リンクでなくコピーで入れる（リンクが読み込まれない環境向けの予備。
#                                    # 更新のたびに --copy をもう一度実行する。既存のコピーは上書きする）
#
# リンクで入れるので、このリポを `git pull` すればスキルも最新になる。
# 同じ名前のスキルが別に置かれている場合は上書きせず、その名前を報告して終了コード 1 で終わる。
set -euo pipefail

mode="${1:-install}"
repo="$(cd "$(dirname "$0")/.." && pwd)"
dest="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

case "$mode" in
  install|--check|--uninstall|--copy) ;;
  *) echo "使い方: bash setup/install.sh [--check|--uninstall|--copy]" >&2; exit 2 ;;
esac

{ [ "$mode" = install ] || [ "$mode" = --copy ]; } && mkdir -p "$dest"

ok=0; added=0; removed=0; conflicts=()
for skill_md in "$repo"/skills/*/SKILL.md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  target="$dest/$name"

  if [ "$mode" = --copy ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then rm "$target"; fi
    if [ -L "$target" ]; then
      conflicts+=("$name"); echo "衝突  : $name（$target は別の場所へのリンク。上書きしない）"; continue
    fi
    rm -rf "${target:?}"; cp -R "$src" "$target"; added=$((added + 1)); echo "コピー: $name"
  elif [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    if [ "$mode" = --uninstall ]; then
      rm "$target"; removed=$((removed + 1)); echo "外した: $name"
    else
      ok=$((ok + 1)); echo "OK    : $name"
    fi
  elif [ "$mode" = --check ] && [ -d "$target" ] && [ ! -L "$target" ] && diff -rq "$src" "$target" >/dev/null 2>&1; then
    ok=$((ok + 1)); echo "OK    : $name（コピーで入っている）"
  elif [ -e "$target" ] || [ -L "$target" ]; then
    conflicts+=("$name")
    echo "衝突  : $name（$target に別のものがある。上書きしない）"
  elif [ "$mode" = install ]; then
    ln -s "$src" "$target"; added=$((added + 1)); echo "入れた: $name"
  elif [ "$mode" = --check ]; then
    echo "未導入: $name"
    conflicts+=("$name")
  fi
done

echo
case "$mode" in
  --copy)      echo "コピーした ${added} / 衝突 ${#conflicts[@]}（置き場: $dest）" ;;
  install)     echo "入れた ${added} / 入っていた ${ok} / 衝突 ${#conflicts[@]}（置き場: $dest）" ;;
  --check)     echo "入っている ${ok} / 足りない・衝突 ${#conflicts[@]}（置き場: $dest）" ;;
  --uninstall) echo "外した ${removed}（このリポのリンク以外には触っていない）"; exit 0 ;;
esac

[ ${#conflicts[@]} -eq 0 ]
