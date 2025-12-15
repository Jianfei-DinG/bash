#!/usr/bin/env bash
set -e

echo "====== 1. 安装 nvm ======"

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
else
  echo "nvm 已存在，跳过安装"
fi

echo "====== 2. 加载 nvm 环境 ======"

# 不依赖重开 shell
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "❌ nvm.sh 未找到"
  exit 1
fi

echo "====== 3. 安装 Node.js v24 ======"

if ! nvm ls 24 >/dev/null 2>&1; then
  nvm install 24
else
  echo "Node.js v24 已安装，跳过"
fi

nvm use 24

echo "====== 4. 验证 Node / npm ======"

node -v
npm -v

echo "====== 5. 安装 PM2 ======"

npm install -g pm2@latest

echo "====== 6. 验证 PM2 ======"
pm2 -v

echo "✅ 全部完成"
