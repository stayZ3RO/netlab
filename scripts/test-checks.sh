#!/usr/bin/env bash
# Run each failure case in its own clean local clone.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

check() (
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

python3 scripts/check-relative-links.py
)

for kind in empty sensitive link; do
    site="$tmp/$kind"
    git clone -q --local "$root" "$site"
    cd "$site"
    check > "$tmp/output"
    echo "PASS clean: $kind"
    case "$kind" in
        empty) touch empty-fixture.md; expected='Empty Markdown files found:' ;;
        sensitive) touch fixture.pem; expected='Potential sensitive files found:' ;;
        link)
            echo '[Fixture](missing-target.txt)' > link-fixture.md
            git add link-fixture.md
            expected='Missing local link target: missing-target.txt' ;;
    esac
    if check > "$tmp/output" 2>&1; then
        echo "FAIL: $kind fixture passed" >&2
        exit 1
    fi
    grep -Fq "$expected" "$tmp/output" || { cat "$tmp/output" >&2; exit 1; }
    echo "PASS seeded failure caught: $kind"
done
