#!/bin/bash
# ============================================================
# new-slide.sh — テンプレートを指定ディレクトリに複製・初期化
# ============================================================
# 使い方:
#   ./scripts/new-slide.sh [テンプレート名] [作成先ディレクトリ] [スライド名]
#
# 例:
#   # カレント以外の別案件ディレクトリに作成する場合:
#   ./scripts/new-slide.sh basic ~/Base/研究発表スライド "中間報告"
#
# テンプレート名: basic | data-report | lecture (既定: basic)
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MASTER_DIR="$(dirname "$SCRIPT_DIR")"

TEMPLATE="${1:-basic}"
TARGET_DIR="${2:-}"
TITLE="${3:-プレゼンテーション}"

if [ -z "$TARGET_DIR" ]; then
    echo "❌ 作成先のディレクトリパスを指定してください。"
    echo "使い方: $0 [テンプレート名] [作成先ディレクトリ] [スライド名]"
    echo ""
    echo "例: $0 basic ~/Base/新プロジェクト \"プロジェクト企画\""
    exit 1
fi

TEMPLATE_FILE="$MASTER_DIR/templates/$TEMPLATE.qmd"
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "❌ テンプレートが見つかりません: $TEMPLATE_FILE"
    echo "使えるテンプレート: basic, data-report, lecture"
    exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# テーマと設定をコピー（まだ存在しない場合）
if [ ! -d "$TARGET_DIR/themes" ]; then
    cp -r "$MASTER_DIR/themes" "$TARGET_DIR/"
fi
if [ ! -f "$TARGET_DIR/_quarto.yml" ]; then
    cp "$MASTER_DIR/_quarto.yml" "$TARGET_DIR/"
fi

# スライドファイルの作成
DATE_PREFIX="$(date +%Y%m%d)"
SAFE_TITLE="$(echo "$TITLE" | tr '/' '_' | tr ' ' '_')"
SLIDE_FILE="${DATE_PREFIX}_${SAFE_TITLE}.qmd"

cp "$TEMPLATE_FILE" "$SLIDE_FILE"

# タイトル置換 (macOS / Linux 互換)
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/タイトルを入力/$TITLE/g" "$SLIDE_FILE"
    sed -i '' "s/データ分析タイトル/$TITLE/g" "$SLIDE_FILE"
    sed -i '' "s/講義タイトル/$TITLE/g" "$SLIDE_FILE"
else
    sed -i "s/タイトルを入力/$TITLE/g" "$SLIDE_FILE"
    sed -i "s/データ分析タイトル/$TITLE/g" "$SLIDE_FILE"
    sed -i "s/講義タイトル/$TITLE/g" "$SLIDE_FILE"
fi

echo "✅ 新規スライド環境を初期化しました:"
echo "   場所: $TARGET_DIR/$SLIDE_FILE"
echo ""
echo "次のステップ:"
echo "   cd $TARGET_DIR"
echo "   quarto preview $SLIDE_FILE"
