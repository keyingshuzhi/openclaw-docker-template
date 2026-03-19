# 渠道接入指南

本文档说明如何把 OpenClaw 接入常见聊天渠道（Telegram/Discord/Slack/WhatsApp）。

## 1. 接入前检查

先确保网关已启动：

```bash
./scripts/start.sh
```

查看渠道总体状态：

```bash
docker compose run --rm openclaw-cli channels status
```

## 2. Telegram

```bash
docker compose run --rm openclaw-cli channels add --channel telegram --token "<bot-token>"
```

`<bot-token>` 可来自 `.env` 中 `TELEGRAM_BOT_TOKEN`，也可以命令行临时传入。

## 3. Discord

```bash
docker compose run --rm openclaw-cli channels add --channel discord --token "<bot-token>"
```

接入后建议执行能力探测：

```bash
docker compose run --rm openclaw-cli channels capabilities --channel discord
```

## 4. Slack

Slack 需要 bot token + app token，推荐使用交互向导：

```bash
docker compose run --rm openclaw-cli channels add --channel slack
```

如果你已经在 `.env` 配置了 `SLACK_BOT_TOKEN` / `SLACK_APP_TOKEN`，向导中可直接复用。

## 5. WhatsApp

WhatsApp 通常需要登录流程：

```bash
docker compose run --rm openclaw-cli channels login
```

## 6. 诊断命令

```bash
docker compose run --rm openclaw-cli channels list
docker compose run --rm openclaw-cli channels status --probe
docker compose run --rm openclaw-cli channels logs
```

## 7. 安全建议

1. 仅开启你实际使用的渠道。
2. 渠道 token 一律走环境变量或 Secret 管理。
3. 上线前先在测试群/测试频道验证权限和消息回路。
