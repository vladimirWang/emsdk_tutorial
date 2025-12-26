#!/usr/bin/env bash
# 脚本名称：side_module_build.sh
# 功能：使用emcc编译side_module.c生成side_module.wasm（适配~/wasm_workspace/emsdk_tute目录结构）
# 核心参数：启用边模块(SIDE_MODULE=2)、导出_Increment函数

# 开启严格模式：遇错误退出、未定义变量报错、管道错误传递
set -euo pipefail

# 定义颜色输出（提升可读性）
RED='\033[0;31m'    # 错误提示色
GREEN='\033[0;32m'  # 成功提示色
NC='\033[0m'        # 恢复默认色

# -------------------------- 第一步：检查环境依赖 --------------------------
# 检查emcc是否已加载（需先通过source emsdk_env.sh激活环境）
if ! command -v emcc &> /dev/null; then
    echo -e "${RED}错误：未检测到emcc命令！请先执行 'source 你的emsdk路径/emsdk_env.sh' 加载环境${NC}"
    exit 1
fi

# -------------------------- 第二步：检查源文件存在性 --------------------------
# 适配图二文件结构（当前目录需包含side_module.c）
SOURCE_FILE="side_module.c"
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}错误：当前目录未找到$SOURCE_FILE！请确认脚本与$SOURCE_FILE在同一目录（参考路径：~/wasm_workspace/emsdk_tute）${NC}"
    exit 1
fi

# -------------------------- 第三步：执行核心编译命令 --------------------------
# 图一核心命令适配：生成边模块+导出_Increment函数，输出side_module.wasm
OUTPUT_WASM="side_module.wasm"
COMPILE_CMD="emcc $SOURCE_FILE -o $OUTPUT_WASM -s SIDE_MODULE=2 -s EXPORTED_FUNCTIONS='[\"_Increment\"]'"

echo -e "${GREEN}开始编译：$COMPILE_CMD${NC}"
eval "$COMPILE_CMD"  # 执行编译命令（eval处理带引号的参数）

# -------------------------- 第四步：验证编译结果 --------------------------
# 检查目标wasm文件是否生成，同时关联图二中的1.html（提示使用场景）
if [ -f "$OUTPUT_WASM" ]; then
    echo -e "${GREEN}编译成功！已生成：$OUTPUT_WASM${NC}"
    # 适配图二文件结构：提示与1.html的关联用法
    if [ -f "1.html" ]; then
        echo -e "${GREEN}提示：当前目录存在1.html，可在HTML中通过WebAssembly API加载$OUTPUT_WASM调用_Increment函数${NC}"
    else
        echo -e "${GREEN}提示：若需在网页中使用$OUTPUT_WASM，可参考图二结构创建1.html并添加WASM加载逻辑${NC}"
    fi
else
    echo -e "${RED}编译失败：未生成$OUTPUT_WASM${NC}"
    exit 1
fi