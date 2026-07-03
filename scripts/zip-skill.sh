#!/usr/bin/env bash
set -e

# 执行脚本时传进去的第一个参数，例如 frontend-dev-coach
SKILL_NAME="$1"

# 如果没有传 Skill 名称，就提示正确用法并退出
if [ -z "$SKILL_NAME" ]; then
  echo "用法: ./scripts/zip-skill.sh frontend-dev-coach"
  exit 1
fi

# 检查 Skill 文件夹是否存在
if [ ! -d "skills/$SKILL_NAME" ]; then
  echo "找不到 skills/$SKILL_NAME"
  exit 1
fi

# 创建 dist 文件夹；如果已存在，不会报错
mkdir -p dist

# 进入 skills 目录，这样 zip 里不会多一层 skills/
cd skills

# 把 Skill 文件夹压缩到 dist 目录
zip -r "../dist/$SKILL_NAME.zip" "$SKILL_NAME"

# 回到仓库根目录
cd ..

# 输出成功提示
echo "已生成: dist/$SKILL_NAME.zip"