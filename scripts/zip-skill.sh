#!/usr/bin/env bash
set -e

mkdir -p dist

zip_skill() {
  local skill_name="$1"

  if [ ! -d "skills/$skill_name" ]; then
    echo "找不到 skills/$skill_name"
    exit 1
  fi

  (
    cd skills
    zip -rqFS "../dist/$skill_name.zip" "$skill_name" \
      -x "*/.DS_Store" "*/__pycache__/*"
  )

  echo "已生成: dist/$skill_name.zip"
}

if [ "$#" -gt 0 ]; then
  for skill_name in "$@"; do
    zip_skill "$skill_name"
  done
  exit 0
fi

found_skill=false

for skill_dir in skills/*/; do
  [ -d "$skill_dir" ] || continue
  found_skill=true
  skill_name="${skill_dir%/}"
  zip_skill "${skill_name##*/}"
done

if [ "$found_skill" = false ]; then
  echo "skills/ 下没有可打包的 Skill"
  exit 1
fi
