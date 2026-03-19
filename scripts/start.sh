#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [ ! -f .env ]; then
  echo "[ERROR] .env 不存在，请先创建并配置。"
  exit 1
fi

mkdir -p data/workspace data/logs data/tmp data/credentials

echo "[INFO] 拉取镜像（如本地已有将跳过）..."
docker compose pull openclaw-gateway openclaw-cli

echo "[INFO] 启动 openclaw-gateway..."
docker compose up -d openclaw-gateway

PORT="$(grep -E '^OPENCLAW_GATEWAY_PORT=' .env | tail -n1 | cut -d'=' -f2-)"
PORT="${PORT:-18789}"

echo "[OK] Gateway 已启动: http://127.0.0.1:${PORT}"
echo "[TIP] 首次建议执行: docker compose run --rm openclaw-cli onboard"
