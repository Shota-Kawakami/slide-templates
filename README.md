# プレゼン資料モデル

Quarto + Reveal.js によるプログラマティックなスライド作成テンプレート集。

## クイックスタート

### 1. 新しいスライドを作る

```bash
cd プレゼン資料モデル
./scripts/new-slide.sh basic "売上分析レポート"
```

テンプレートは3種類：

| テンプレート | コマンド | 用途 |
|---|---|---|
| 汎用 | `./scripts/new-slide.sh basic "タイトル"` | 一般的なプレゼン |
| データ分析 | `./scripts/new-slide.sh data-report "タイトル"` | CSV/グラフ付き |
| 講義 | `./scripts/new-slide.sh lecture "タイトル"` | ゼミ・授業 |

### 2. スライドを編集する

生成された `.qmd` ファイルを開いて、Markdown でスライドを書く。

### 3. プレビュー（ライブリロード付き）

```bash
quarto preview 20261027_売上分析レポート.qmd
```

ブラウザで自動プレビューが開く。ファイルを保存するたびにリロード。

### 4. HTMLに変換

```bash
quarto render 20261027_売上分析レポート.qmd
```

`output/` ディレクトリに HTML が出力される。

### 5. 一括ビルド

```bash
./scripts/build.sh         # 全スライドをビルド
./scripts/build.sh clean   # output/ をクリア
```

## ディレクトリ構成

```
プレゼン資料モデル/
├── _quarto.yml          # 共通設定（テーマ・出力先を一元管理）
├── RULES.md             # スライド作成ルール
├── README.md            # ← このファイル
├── themes/
│   ├── dracula.scss     # ダークテーマ
│   ├── light.scss       # ライトテーマ
│   └── shared.css       # 囲み・マーカー等の共通部品
├── templates/
│   ├── basic.qmd        # 汎用テンプレート
│   ├── data-report.qmd  # データ分析テンプレート
│   └── lecture.qmd      # 講義テンプレート
├── examples/
│   └── demo.qmd         # 全機能デモ
├── scripts/
│   ├── new-slide.sh     # 新規作成スクリプト
│   └── build.sh         # 一括ビルドスクリプト
├── assets/              # 共有画像・ロゴ
└── output/              # レンダリング済みHTML
```

## テーマ切替

`_quarto.yml` の1行を変更するだけ：

```yaml
# ダーク（既定）
theme: [default, themes/dracula.scss]

# ライト
theme: [default, themes/light.scss]
```

## 前提条件

- [Quarto](https://quarto.org/) 1.4+
- R（data-report テンプレート使用時）
  - ggplot2, dplyr, scales パッケージ

## デモの確認

```bash
quarto preview examples/demo.qmd
```

全スタイルクラスの見た目をブラウザで確認できます。

## 関連ドキュメント

- [RULES.md](RULES.md) — スライド作成ルール・命名規則
- [Quarto Reveal.js ドキュメント](https://quarto.org/docs/presentations/revealjs/)

