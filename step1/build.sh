#!/usr/bin/env bash

# 脚本名称：compile_wasm.sh
# 功能：使用emcc编译calculate.c为output.html

# 开启严格模式，遇到错误立即退出
set -euo pipefail

# 定义颜色（可选，用于美化输出）
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # 恢复默认颜色

# 第一步：检查emcc是否安装
if ! command -v emcc &> /dev/null; then
    echo -e "${RED}错误：未找到emcc命令，请先安装Emscripten环境！${NC}"
    exit 1
fi

# 第二步：检查源文件是否存在
if [ ! -f "calculate.c" ]; then
    echo -e "${RED}错误：当前目录未找到calculate.c文件！${NC}"
    exit 1
fi

# 第三步：执行编译命令
echo -e "${GREEN}开始编译：emcc calculate.c -o output.html${NC}"
emcc calculate.c -o output.html

# 第四步：验证编译结果
if [ -f "output.html" ]; then
    echo -e "${GREEN}编译成功！已生成output.html文件${NC}"
else
    echo -e "${RED}编译失败：未生成output.html文件${NC}"
    exit 1
fi