#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <source-directory>"
  echo "Example: $0 /path/to/source/project"
  exit 1
fi

SOURCE_DIR="$1"

# Validate source directory
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

if [ ! -f "$SOURCE_DIR/package.json" ]; then
  echo "Error: package.json not found in source directory"
  exit 1
fi

# Get directory name for commit message
DIR_NAME=$(basename "$SOURCE_DIR")

# Get script directory (this project root)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Building in: $SOURCE_DIR"

# Run npm build in source directory
echo "Running npm run build..."
cd "$SOURCE_DIR"
npm run build

# Copy built files
echo "Copying main.js and styles.css..."
cp "$SOURCE_DIR/main.js" "$SCRIPT_DIR/main.js"
cp "$SOURCE_DIR/styles.css" "$SCRIPT_DIR/styles.css"

# Git add and commit
echo "Committing changes..."
cd "$SCRIPT_DIR"
git add -A
git commit -m "$DIR_NAME"

# Bump version
echo "Bumping version..."
npm version patch

# Push
echo "Pushing to remote..."
git push

echo "Done!"
