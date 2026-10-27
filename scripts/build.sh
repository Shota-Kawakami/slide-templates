#!/bin/bash
# ============================================================
# build.sh — プロジェクト内の全 .qmd を一括レンダリング
# ============================================================
# 使い方:
#   ./scripts/build.sh           # プロジェクトルートの .qmd を全部ビルド
#   ./scripts/build.sh clean     # output/ を削除
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

case "${1:-build}" in
    build)
        echo "🔨 ビルド開始..."
        echo ""

        # プロジェクトルート直下の .qmd（テンプレートやサンプルは除外）
        FILES=$(find "$PROJECT_DIR" -maxdepth 1 -name "*.qmd" -type f | sort)

        if [ -z "$FILES" ]; then
            echo "⚠️  プロジェクトルートに .qmd ファイルがありません。"
            echo "   ./scripts/new-slide.sh でスライドを作成してください。"
            exit 0
        fi

        SUCCESS=0
        FAIL=0

        while IFS= read -r f; do
            NAME=$(basename "$f")
            echo "  📄 $NAME ..."
            if quarto render "$f" 2>/dev/null; then
                echo "     ✅ 完了"
                SUCCESS=$((SUCCESS + 1))
            else
                echo "     ❌ エラー"
                FAIL=$((FAIL + 1))
            fi
        done <<< "$FILES"

        echo ""
        echo "🏁 ビルド完了: ✅ $SUCCESS 成功 / ❌ $FAIL 失敗"
        ;;

    clean)
        echo "🗑  output/ を削除します..."
        rm -rf "$PROJECT_DIR/output"
        mkdir -p "$PROJECT_DIR/output"
        touch "$PROJECT_DIR/output/.gitkeep"
        echo "✅ クリーン完了"
        ;;

    *)
        echo "使い方: $0 [build|clean]"
        exit 1
        ;;
esac

