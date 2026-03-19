# OpenClaw Docker 部署文档

## 1. 架构总览

本项目采用双容器架构：

- `openclaw-gateway`：常驻服务，提供网关/API/Web 控制入口
- `openclaw-cli`：运维工具容器，用于 `onboard`、`configure`、渠道管理

数据持久化在宿主机 `data/`：

- `data/openclaw.json`：核心运行配置
- `data/workspace/`：Agent 工作区上下文

```text
Channels / Browser
        |
        v
+-----------------------+
| openclaw-gateway      | 18789 (gateway/http)
|                       | 18790 (bridge)
+-----------------------+
        ^
        | shared network + volumes
+-----------------------+
| openclaw-cli          | 一次性命令执行容器
+-----------------------+
        |
        v
+-----------------------+
| ./data (host volume)  |
+-----------------------+
```

## 2. 前置要求

- Docker Engine 24+
- Docker Compose V2
- 可访问镜像仓库（默认 `ghcr.io/openclaw/openclaw:latest`）

## 3. 部署步骤

### 3.1 配置环境变量

编辑仓库根目录 `.env`，至少完成以下配置：

- `OPENCLAW_GATEWAY_TOKEN`：网关鉴权令牌
- 至少一个模型提供方密钥（推荐 `DEEPSEEK_API_KEY`）

### 3.2 启动网关

```bash
./scripts/start.sh
```

### 3.3 首次初始化

```bash
docker compose run --rm openclaw-cli onboard
```

向导会引导你完成模型、网关、渠道等基础设置。

### 3.4 健康检查

```bash
docker compose ps
curl -fsS http://127.0.0.1:18789/healthz
```

## 4. 日常运维

```bash
./scripts/logs.sh                 # 默认看 gateway 日志
./scripts/logs.sh openclaw-cli    # 看 cli 容器日志
./scripts/restart.sh              # 重启 gateway
./scripts/stop.sh                 # 停止全部容器
```

## 5. 升级流程

```bash
docker compose pull
./scripts/restart.sh
```

建议升级前备份 `data/`：

```bash
tar czf backup-openclaw-$(date +%Y%m%d-%H%M%S).tgz data
```

## 6. 常见问题

1. 网关端口冲突
   - 修改 `.env` 中 `OPENCLAW_GATEWAY_PORT` / `OPENCLAW_BRIDGE_PORT`
2. 鉴权失败（401/403）
   - 检查调用端是否携带 `OPENCLAW_GATEWAY_TOKEN`
3. 模型调用失败
   - 检查 `.env` 的 API Key 是否已配置且生效
