# OpenClaw 配置说明

## 1. 配置优先级

一般建议通过这两层管理配置：

1. `.env`：容器启动参数、密钥、端口、路径
2. `data/openclaw.json`：OpenClaw 运行时配置（agent/channel 等）

## 2. `.env` 关键变量

| 变量 | 说明 | 示例 |
| --- | --- | --- |
| `OPENCLAW_IMAGE` | OpenClaw 镜像 | `ghcr.io/openclaw/openclaw:latest` |
| `OPENCLAW_CONFIG_DIR` | 宿主机配置目录 | `./data` |
| `OPENCLAW_WORKSPACE_DIR` | 宿主机工作区目录 | `./data/workspace` |
| `OPENCLAW_GATEWAY_BIND` | 监听模式 | `lan` |
| `OPENCLAW_GATEWAY_PORT` | 网关端口映射 | `18789` |
| `OPENCLAW_BRIDGE_PORT` | bridge 端口映射 | `18790` |
| `OPENCLAW_GATEWAY_TOKEN` | 网关鉴权 token | `change-...` |
| `DEEPSEEK_API_KEY` | DeepSeek 直连密钥（推荐） | `sk-...` |
| `OPENAI_API_KEY` | OpenAI 密钥（可选） | `sk-...` |
| `ANTHROPIC_API_KEY` | Anthropic 密钥（可选） | `sk-ant-...` |
| `GEMINI_API_KEY` | Gemini 密钥（可选） | `...` |
| `OPENROUTER_API_KEY` | OpenRouter 密钥（可选） | `sk-or-...` |
| `TELEGRAM_BOT_TOKEN` | Telegram token（可选） | `123456:ABC...` |
| `DISCORD_BOT_TOKEN` | Discord token（可选） | `...` |
| `SLACK_BOT_TOKEN` | Slack bot token（可选） | `xoxb-...` |
| `SLACK_APP_TOKEN` | Slack app token（可选） | `xapp-...` |

## 3. `data/openclaw.json` 最小示例

```json
{
  "agents": {
    "defaults": {
      "workspace": "/home/node/.openclaw/workspace"
    }
  }
}
```

## 4. 安全建议

1. 生产环境务必替换 `OPENCLAW_GATEWAY_TOKEN` 为高强度随机值。
2. 不要把 `.env` 提交到公开仓库。
3. `OPENCLAW_ALLOW_INSECURE_PRIVATE_WS` 默认留空，仅在明确需求下启用。
4. 若要挂载 Docker Socket，请只在可信主机使用并限制访问权限。

## 5. 变更建议

1. 修改配置前先备份 `data/`。
2. 每次修改后执行：

```bash
docker compose config --quiet
./scripts/restart.sh
```
