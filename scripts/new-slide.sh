#!/bin/bash
# ============================================================
# new-slide.sh — テンプレートからスライドを新規作成
# ============================================================
# 使い方:
#   ./scripts/new-slide.sh [テンプレート名] [タイトル]
#
# 例:
#   ./scripts/new-slide.sh basic "売上分析レポート"
#   ./scripts/new-slide.sh data-report "Q3決算分析"
#   ./scripts/new-slide.sh lecture "第5回 回帰分析"
#
# テンプレート名を省略すると basic が使われます。
# ============================================================

set -euo pipefail

# --- このスクリプトのあるディレクトリからプロジェクトルートを取得 ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# --- 引数処理 ---
TEMPLATE="${1:-basic}"
TITLE="${2:-新規スライド}"

# --- テンプレートファイルの確認 ---
TEMPLATE_FILE="$PROJECT_DIR/templates/$TEMPLATE.qmd"
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "❌ テンプレートが見つかりません: $TEMPLATE_FILE"
    echo ""
    echo "使えるテンプレート:"
    ls "$PROJECT_DIR/templates/"*.qmd 2>/dev/null | while read f; do
        basename "$f" .qmd
    done
    exit 1
fi

# --- 出力ファイル名を生成 ---
DATE_PREFIX="$(date +%Y%m%d)"
# タイトルからファイル名に使えない文字を除去
SAFE_TITLE="$(echo "$TITLE" | tr '/' '_' | tr ' ' '_')"
OUTPUT_FILE="$PROJECT_DIR/${DATE_PREFIX}_${SAFE_TITLE}.qmd"

# --- 既存チェック ---
if [ -f "$OUTPUT_FILE" ]; then
    echo "⚠️  ファイルが既に存在します: $OUTPUT_FILE"
    read -p "上書きしますか? (y/N): " CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "中止しました。"
        exit 0
    fi
fi

# --- コピー ---
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

# --- タイトルを置換 ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS の sed
    sed -i '' "s/タイトルを入力/$TITLE/g" "$OUTPUT_FILE"
    sed -i '' "s/データ分析タイトル/$TITLE/g" "$OUTPUT_FILE"
    sed -i '' "s/講義タイトル/$TITLE/g" "$OUTPUT_FILE"
else
    sed -i "s/タイトルを入力/$TITLE/g" "$OUTPUT_FILE"
    sed -i "s/データ分析タイトル/$TITLE/g" "$OUTPUT_FILE"
    sed -i "s/講義タイトル/$TITLE/g" "$OUTPUT_FILE"
fi

echo "✅ 作成しました: $OUTPUT_FILE"
echo ""
echo "次のステップ:"
echo "  1. ファイルを開いて内容を編集"
echo "  2. quarto preview $OUTPUT_FILE  # ライブプレビュー"
echo "  3. quarto render $OUTPUT_FILE   # HTMLに変換"

