# AI Agent 共有スキル

Claude Code / Cursor Agent で使えるスキルを、チームメンバー・クライアント・協力者と共有するためのリポジトリ。

## 含まれるスキル

| スキル | 用途 | チャットでの呼び方 |
|--------|------|-------------------|
| [grill-me](./grill-me/) | 計画・設計を1問ずつ深掘りし、実装前に論点を整理する | 「グリルして」「計画を詰めて」「要件を深掘りして」 |

## 配置先について（ユーザースキルを推奨）

スキルの置き場所は2種類ありますが、**ユーザースキル（`~/.claude/skills/`）を推奨**します。

- **ユーザースキル（推奨）**: ホームフォルダの `~/.claude/skills/` に置く。どのプロジェクトからでも呼び出せる。grill-me は企画・文章作成・業務整理など汎用的に使えるスキルなので、こちらが向いている
- **プロジェクトスキル**: 特定プロジェクトのルートの `.claude/skills/` に置く。そのプロジェクトだけで使う・リポジトリごとチームで共有する場合はこちら

なお **Cursor も `.claude/skills/` をスキルとして認識する**ため、Claude Code / Cursor どちらのユーザーも同じ配置でOKです（`~/.cursor/skills/` を分けて作る必要はありません）。

## インストール

### 前提

- [Claude Code](https://claude.com/claude-code) または [Cursor](https://cursor.com/) がインストール済みであること

### 方法 A: AI にやってもらう（推奨）

Claude Code または Cursor（Agent モード）のチャットに、以下をまるごとコピーして貼り付けて送信してください。AI が配置先を確認してくるので、チャットで回答すれば配置まで完了します。

```
https://github.com/pon3yamada/shared-cursor-skills.git を clone して、grill-me スキルを配置してください。Git が入っていなければ先にインストールしてください。

配置する前に、配置先について私に確認してください:
- ユーザースキル（~/.claude/skills/grill-me/）に置く — どのプロジェクトからでも使いたい場合（推奨）
- プロジェクトスキル（対象プロジェクトの .claude/skills/grill-me/）に置く — そのプロジェクトだけで使う場合

配置が終わったら、新しいチャットで「グリルして」と話しかけて動作確認できることを教えてください。
```

### 方法 B: 手動で入れる

```bash
# 1. リポジトリを clone（URL は山田から共有されたものに置き換え）
git clone https://github.com/pon3yamada/shared-cursor-skills.git
cd shared-cursor-skills

# 2. ユーザースキルとして配置（推奨）
mkdir -p ~/.claude/skills
cp -r grill-me ~/.claude/skills/

# 3. Claude Code / Cursor を再起動するか、新しいチャットを開く
```

ZIP で渡された場合は、展開後に手順2以降を実行する。

### 方法 C: 特定プロジェクトだけで使う

そのプロジェクトのルートに `.claude/skills/` を作り、そこにコピーする。

```bash
mkdir -p .claude/skills
cp -r /path/to/shared-cursor-skills/grill-me .claude/skills/
```

## 使い方

1. Claude Code または Cursor（Agent モード）のチャットを開く
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

方法 B で入れた場合:

```bash
cd shared-cursor-skills
git pull
cp -r grill-me ~/.claude/skills/
```

方法 A で入れた場合は、clone 済みのフォルダを AI に伝えて「最新化して配置し直して」と頼めばよい。

## 共有・運用（山田向けメモ）

- ローカル置き場: `ai-workbench/shared/cursor-skills`（他人に渡す用ホーム `shared/` 配下）
- マスターは `~/.claude/skills/grill-me/SKILL.md`（山田のユーザースキル）。更新したらこのリポジトリにコピーして commit → push する
- `CLAUDE.md` と `AGENTS.md` は同内容（Claude Code 用と Cursor 用）。clone した人がこのリポジトリをエージェントで開いたときに「配置先を確認してから配置する」動作を仕込んである。片方を直したらもう片方も同期する
- このリポジトリは `client-work` や ABiL 案件リポとは別管理にする（クライアントデータと混ぜない）
- GitHub は **Public で運用**（grill-me に機密はなく、共有相手が clone するだけで使えるようにするため）。機密を含むスキルを将来追加する場合は、このリポジトリではなく別の Private リポジトリに分ける
- スキルを追加するときは `/<skill-name>/SKILL.md` を増やし、上の表を更新する
