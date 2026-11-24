"""Check the phase links and compare front-page statuses to the phase badges."""
import re
import sys
from pathlib import Path
from urllib.parse import unquote

root = Path(__file__).resolve().parents[1]
indexes = {name: (root / name).read_text() for name in ("README.md", "ROADMAP.md")}
phase_dirs = sorted(p for p in (root / "docs").glob("phase-*") if p.is_dir())
errors = []
if not phase_dirs:
    errors.append("No phase directories found")

table = indexes["README.md"].partition("## Completed and Planned Phases\n")[2].split("\n## ", 1)[0]
rows = re.findall(r"^\| Phase (\d+) - [^|]+\|\s*[^A-Za-z|]*([A-Za-z ]+?)\s*\|", table, re.M)
for folder in phase_dirs:
    rel = folder.relative_to(root).as_posix()
    for name, text in indexes.items():
        if not re.search(r"\]\((?:\./)?" + re.escape(rel) + r"(?:/[^)]*)?\)", text):
            errors.append(f"{name}: missing link to {rel}")
    number = folder.name.split("-")[1]
    statuses = [value for n, value in rows if n == number]
    page = folder / "README.md"
    badge = re.search(r"^!\[Status\]\(https://img\.shields\.io/badge/Status-([^-]+)-[^)]+\)",
                      page.read_text() if page.is_file() else "", re.M)
    if not badge or statuses != [unquote(badge[1])]:
        errors.append(f"Phase {number}: expected one table row matching the status badge in {rel}")

if errors:
    sys.exit("\n".join(errors))
print(f"{len(phase_dirs)} phases agree")
