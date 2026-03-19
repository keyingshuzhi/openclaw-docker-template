#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[INFO] 重启 openclaw-gateway..."
docker compose restart openclaw-gateway

echo "[OK] 重启完成。"
