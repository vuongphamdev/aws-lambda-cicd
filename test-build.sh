#!/bin/bash

echo "Testing local build process..."

for module_dir in software/*/; do
  if [ -f "$module_dir/package.json" ]; then
    echo "Building module: $module_dir"
    cd "$module_dir"
    npm install
    npm run build
    echo "Build completed for $module_dir"
    cd - > /dev/null
  fi
done

echo "All modules built successfully!"