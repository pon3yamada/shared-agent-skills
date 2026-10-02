# 追加セット: 録音から直接文字起こしする（whisper）

`meeting-notes` は、ふだんは Notta などで文字起こしした txt を渡して使う。慣れてきて「録音ファイルを渡すだけで済ませたい」「固有名詞の聞き間違いを減らしたい」と思ったら、パソコンの中で動く文字起こしツール **whisper** を足す。

- 対象: Mac（Apple シリコン / M1 以降を想定）
- 必要な空き容量: 約 2GB（モデルファイルが約 1.6GB）
- 所要時間: 15〜30 分（ほとんどはダウンロード待ち）

## AI に頼む場合（おすすめ）

Claude Code に次をそのまま送る:

```
~/shared-agent-skills/docs/whisper-addon.md を読んで、whisper を入れてください。
パスワードが必要なコマンドは、ターミナルに貼るコマンドとして私に渡してください。
```

## 手順（AI がこの順に進める）

### 1. Homebrew があるか確かめる

```bash
which brew
```

何も表示されなければ、Homebrew（Mac にツールを入れるための道具）が無い。**パスワード入力が要るので、本人が「ターミナル」アプリで実行する**:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

終わりに表示される「Next steps」の2行（`echo ... >> ~/.zprofile` と `eval ...`）も、そのまま実行する。

### 2. whisper を入れる

```bash
brew install whisper-cpp
```

### 3. モデルを取ってくる

```bash
mkdir -p ~/models/whisper
curl -L -o ~/models/whisper/ggml-large-v3-turbo.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin
curl -L -o ~/models/whisper/ggml-silero-v5.1.2.bin \
  https://huggingface.co/ggml-org/whisper-vad/resolve/main/ggml-silero-v5.1.2.bin
```

1本目（約 1.6GB）が文字起こしの本体、2本目（約 0.9MB）は無音の区間を見分ける部品。

### 4. 試す

```bash
afconvert -f WAVE -d LEI16@16000 -c 1 <録音ファイル> /tmp/mtg.wav
whisper-cli -m ~/models/whisper/ggml-large-v3-turbo.bin -l ja \
  -mc 0 --vad -vm ~/models/whisper/ggml-silero-v5.1.2.bin \
  /tmp/mtg.wav -otxt -of /tmp/mtg
```

`/tmp/mtg.txt` に文字起こしができれば完了。以後は `meeting-notes` に録音ファイルを渡すと、このコマンドで文字起こししてから議事メモを作る。

## 大事な設定（外さないこと）

- `-mc 0`: 文字起こしが同じ文を延々とくり返す暴走を止める
- `--vad -vm …`: 無音の区間で「ご視聴ありがとうございました」のような、実際には言っていない定型文が混ざるのを防ぐ

この2つを外すと、長い無音（離席など）がある録音で、後半がまるごと使えなくなることがある。
