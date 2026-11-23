#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "Markdown files found:"
find . -name "*.md" | sort || true

echo "Checking for files that should not be committed..."
FOUND="$(find . \
  -path "./.git" -prune -o \
  \( \
    -name ".env" -o \
    -name ".env.local" -o \
    -name ".env.production" -o \
    -name ".env.*" -o \
    -name "*.pem" -o \
    -name "*.key" -o \
    -name "*.p12" -o \
    -name "*.pfx" -o \
    -name "id_rsa" -o \
    -name "id_ed25519" \
  \) -print)"
if [ -n "$FOUND" ]; then
  echo "Potential sensitive files found:"
  echo "$FOUND"
  exit 1
fi
echo "No obvious sensitive files found."

EMPTY_MD="$(find . -name "*.md" -type f -empty -print)"
if [ -n "$EMPTY_MD" ]; then
  echo "Empty Markdown files found:"
  echo "$EMPTY_MD"
  exit 1
fi
echo "No empty Markdown files found."

python3 scripts/check-status-index.py
python3 scripts/check-relative-links.py
