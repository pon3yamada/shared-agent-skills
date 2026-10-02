# shared-agent-skills — Claude Code はじめてセット

Claude Code を使い始める人向けに、**よく使うスキル**と**最初にやっておく設定**をまとめたセット。AI にプロンプトを1つ貼るだけで、環境が整う。

Cursor でも同じスキルが使える（Cursor も `~/.claude/skills/` を読むため）。

## 入っているもの

### スキル

| スキル | 何をしてくれるか | 話しかけ方の例 |
|---|---|---|
| [grill-me](skills/grill-me/) | 計画やアイデアを1問ずつ深掘りし、抜けている論点を一緒に埋める | 「この計画をグリルして」 |
| [writing-proposals](skills/writing-proposals/) | 誰かに出す提案書を、対話で材料を集めてから書く | 「〇〇を提案したい。提案文を作って」 |
| [plain-writing](skills/plain-writing/) | 文章を、結論から先に読みやすく直す | 「この文面を伝わる文章にして」 |
| [meeting-notes](skills/meeting-notes/) | 打ち合わせの文字起こしから議事メモを作る | 「この文字起こしで議事メモ作って」 |

### 初期設定

- **全体ルール**（`~/.claude/CLAUDE.md`）: 日本語で答える・専門用語に説明を添える・消す前に確認する、など初心者向けの振る舞い。セットアップのときに AI がいくつか質問し、その人用に作る（[雛形](setup/CLAUDE.md.template)）
- **Git と GitHub CLI**: 入っているかを確かめ、無ければ入れてログインまで案内する
- **はじめてガイド**: [docs/getting-started.md](docs/getting-started.md) — Cowork との違い、作業フォルダの作り方、困ったときの頼み方
- **追加セット**: [docs/whisper-addon.md](docs/whisper-addon.md) — 録音ファイルから直接文字起こしできるようにする（慣れてから）

## インストール（Mac）

Claude Code を開き、次をまるごとコピーして送信する。あとは AI の質問に答えていけば終わる（15分ほど）。

```
https://github.com/pon3yamada/shared-agent-skills.git を ~/shared-agent-skills に clone してください。
clone できたら ~/shared-agent-skills/AGENTS.md を読み、「はじめてセットアップ」の手順どおりに、Step 1 から順に進めてください。

私は Claude Code を使うのが初めてです。質問は1つずつ、おすすめを添えてください。
パスワードが必要なコマンドは自分で実行せず、ターミナルに貼るコマンドとして私に渡してください。
```

- `git` が入っていない Mac では、clone のときに「コマンドラインデベロッパツールをインストールしますか？」という画面が出る。「インストール」を押し、終わったらもう一度同じプロンプトを送る
- 終わったら、**新しい会話**で「この計画をグリルして」と話しかけると試せる

### 手で入れる場合

```bash
git clone https://github.com/pon3yamada/shared-agent-skills.git ~/shared-agent-skills
bash ~/shared-agent-skills/setup/install.sh
cp ~/shared-agent-skills/setup/CLAUDE.md.template ~/.claude/CLAUDE.md   # 既にあるなら上書きしないこと
```

`~/.claude/CLAUDE.md` の `{{…}}` は自分で書き換える。

## 更新

Claude Code に「スキルを更新して」と頼む。中身は次の2行:

```bash
git -C ~/shared-agent-skills pull --ff-only
bash ~/shared-agent-skills/setup/install.sh
```

スキルは `~/.claude/skills/` に**リンク**で入っているので、`git pull` するだけで最新になる（`install.sh` は新しく増えたスキルを足すため）。

## 自分用に育てたくなったら

- 自分専用のスキル・設定は `~/.claude/skills/` や `~/.claude/CLAUDE.md` に置く。**`~/shared-agent-skills` の中は書き換えない**（更新のときにぶつかる）
- 配られたスキルを改造したいときは、このリポジトリを自分の GitHub にフォークして切り替える。**フォークは公開になる**ので、仕事の情報や人名は書かない。自分だけのものは非公開のリポジトリへ

---

## 配布元のメモ（山田向け）

- ローカル置き場: `ai-workbench/shared/agent-skills`。GitHub は **Public**。機密・社内ルール・社内システム依存を含むものは入れない
- **スキルの出どころ**:

  | 配布版 | 元にしたスキル（`ai-workbench/.claude/skills/`） | 関係 |
  |---|---|---|
  | grill-me | grill-me | 同じもの。元を直したら、ここへコピーして commit → push |
  | writing-proposals | writing-proposals | 社内文章ルールへの参照を外した版。以後はこちらが正本 |
  | plain-writing | 社内文章ルールのスキル | 社名・社内向けの記述を外し、ルールを書き直した汎用版。以後はこちらが正本 |
  | meeting-notes | mtg-minutes | Notion 反映・Drive 受信箱・リポ構成への依存を外した簡易版。以後はこちらが正本 |

- 元と配布版のずれは機械で見張っていない（2026-10-02 決定）。元を改善したら、気づいたときに手で反映する
- スキルを足すときは `skills/<名前>/SKILL.md` を作り、上の表と「入っているもの」の表を更新する。`install.sh` は `skills/*/SKILL.md` を自動で拾う
- `CLAUDE.md` は `@AGENTS.md` を読み込むだけ。エージェントへの指示は `AGENTS.md` に書く
