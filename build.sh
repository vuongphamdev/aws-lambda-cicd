#!/bin/bash

for module_dir in software/*/; do
  if [ -f "$module_dir/package.json" ]; then
    echo "Building module: $module_dir"
    cd "$module_dir"
    npm install
    npm run build
    cd - > /dev/null
  fi
done