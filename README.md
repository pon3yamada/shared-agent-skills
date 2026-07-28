# Cursor 共有スキル

Cursor Agent 向けのスキルを、クライアント・協力者と共有するためのリポジトリ。

## 含まれるスキル

| スキル | 用途 | チャットでの呼び方 |
|--------|------|-------------------|
| [grill-me](./grill-me/) | 計画・設計を1問ずつ深掘りし、実装前に論点を整理する | 「グリルして」「計画を詰めて」「要件を深掘りして」 |

## インストール（長谷川くん向け）

### 前提

- [Cursor](https://cursor.com/) がインストール済みであること
- Git が使えること（GitHub から clone する場合）

### 方法 A: GitHub から入れる（推奨）

更新があれば `git pull` で取り込める。

```bash
# 1. リポジトリを clone（URL は山田から共有されたものに置き換え）
git clone https://github.com/pon3yamada/shared-cursor-skills.git
cd shared-cursor-skills
# ローカル作業場所の例: ~/ai-workbench/shared/cursor-skills

# 2. 個人スキルとして配置（全プロジェクトで使える）
mkdir -p ~/.cursor/skills
cp -r grill-me ~/.cursor/skills/

# 3. Cursor を再起動するか、新しいチャットを開く
```

### 方法 B: ZIP で渡された場合

```bash
# 展開後
mkdir -p ~/.cursor/skills
cp -r grill-me ~/.cursor/skills/
```

### 方法 C: 特定プロジェクトだけで使う

そのプロジェクトのルートに `.cursor/skills/` を作り、そこにコピーする。

```bash
mkdir -p .cursor/skills
cp -r /path/to/cursor-skills/grill-me .cursor/skills/
```

## 使い方

1. Cursor で Agent モードのチャットを開く
2. 詰めたい計画・設計・アイデアを書く
3. 末尾に「グリルして」と付ける

例:

```
ELC長潟の口コミ誘導フローをこう考えています。
（計画の概要を書く）

この計画をグリルして。
```

Agent が1問ずつ質問し、推奨案付きで論点を整理する。実装やファイル作成は行わない。

## 更新の取り込み

方法 A で入れた場合:

```bash
cd shared-cursor-skills
git pull
cp -r grill-me ~/.cursor/skills/
```

## 共有・運用（山田向けメモ）

- ローカル置き場: `ai-workbench/shared/cursor-skills`（他人に渡す用ホーム `shared/` 配下）
- このリポジトリは `client-work` や ABiL 案件リポとは別管理にする（クライアントデータと混ぜない）
- GitHub は **Private リポジトリ + Collaborator 招待** が無難（grill-me 自体に機密はないが、将来追加するスキル用）
- スキルを追加するときは `/<skill-name>/SKILL.md` を増やし、上の表を更新する
