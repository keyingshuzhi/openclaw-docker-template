#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

SERVICE="${1:-openclaw-gateway}"

echo "[INFO] 查看 ${SERVICE} 日志（Ctrl+C 退出）..."
docker compose logs -f --tail=200 "$SERVICE"
