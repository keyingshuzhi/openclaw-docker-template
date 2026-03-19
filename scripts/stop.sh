#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[INFO] 停止并清理容器（保留数据卷）..."
docker compose down --remove-orphans

echo "[OK] 已停止。"
