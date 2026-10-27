# プレゼン資料モデル（マスター金型）

Quarto + Reveal.js によるプログラマティックなスライド作成のための**設計モデル・テンプレート集（マスター枠組み）**です。

> [!IMPORTANT]
> **運用ルール（マスター保護）**
> このディレクトリは**設計・テンプレート・デモのみを保持するマスター金型**です。  
> 個別のスライド作成（一人暮らし、ゼミ、研究発表等）は、このディレクトリ内には作らず、**案件ごとのディレクトリにテンプレートをコピーして使用**してください。

## テンプレートを使って別フォルダでスライドを作る手順

```bash
# 1. 案件用のディレクトリを作成（または既存フォルダへ移動）
mkdir -p ~/Base/新プレゼン案件
cd ~/Base/新プレゼン案件

# 2. プレゼン資料モデルからテンプレートとテーマをコピー
cp ~/Base/プレゼン資料モデル/templates/basic.qmd ./presentation.qmd
cp -r ~/Base/プレゼン資料モデル/themes ./themes
cp ~/Base/プレゼン資料モデル/_quarto.yml ./

# 3. 編集 & プレビュー
quarto preview presentation.qmd

# 4. ビルド（docs/ フォルダにHTML生成）
quarto render presentation.qmd
```

このリポジトリは GitHub Pages に連携されており、以下のURLでブラウザから直接スライドを閲覧できます：

- 🌐 **ポータル（スライド一覧）**: [https://shota-kawakami.github.io/slide-templates/](https://shota-kawakami.github.io/slide-templates/)
- 🎨 **デモスライド**: [https://shota-kawakami.github.io/slide-templates/examples/demo.html](https://shota-kawakami.github.io/slide-templates/examples/demo.html)

### 更新と自動公開の手順

```bash
# 1. スライド作成・編集
quarto preview <ファイル名>.qmd

# 2. ビルド（docs/ フォルダにHTML生成）
quarto render <ファイル名>.qmd

# 3. push（GitHub Pagesへ反映）
git add -A
git commit -m "スライド追加/更新"
git push
```
数分後に GitHub Pages 側で自動更新されます。

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

