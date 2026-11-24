#!/usr/bin/env bash
# Run each failure case in its own clean local clone.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for kind in empty sensitive link; do
    site="$tmp/$kind"
    git clone -q --local "$root" "$site"
    # Exercise the working copy, including changes made before a commit.
    cp "$root/scripts/"{check.sh,check-status-index.py,check-relative-links.py} "$site/scripts/"
    cd "$site"
    bash scripts/check.sh > "$tmp/output"
    echo "PASS clean: $kind"
    case "$kind" in
        empty) touch empty-fixture.md; expected='Empty Markdown files found:' ;;
        sensitive) touch fixture.pem; expected='Potential sensitive files found:' ;;
        link)
            echo '[Fixture](missing-target.txt)' > link-fixture.md
            git add link-fixture.md
            expected='Missing local link target: missing-target.txt' ;;
    esac
    if bash scripts/check.sh > "$tmp/output" 2>&1; then
        echo "FAIL: $kind fixture passed" >&2
        exit 1
    fi
    grep -Fq "$expected" "$tmp/output" || { cat "$tmp/output" >&2; exit 1; }
    echo "PASS seeded failure caught: $kind"
done
