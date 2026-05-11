#!/bin/bash
# Radagast Bootstrap: Python Context Loader

echo "=== RADAGAST BOOTSTRAP ==="
echo "Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'not a git repo')"
echo "Last Quest: $(git log -1 --pretty=format:'%s' 2>/dev/null || echo 'no commits')"

echo ""
echo "--- Harness State ---"
[ -d .git ] && echo "Git: ✓" || echo "Git: ✗"
[ -f AGENT.md ] && echo "Mandates: ✓" || echo "Mandates: ✗"
[ -f QUEST_PROGRESS.md ] && echo "Progress: ✓" || echo "Progress: ✗"
[ -f docs/contexto.md ] && echo "Context: ✓" || echo "Context: ✗"

echo ""
echo "--- Python Harness ---"
[ -f pyproject.toml ] || [ -f setup.py ] && echo "Package: ✓" || echo "Package: ✗"
[ -f pytest.ini ] || [ -f pyproject.toml ] && echo "Pytest config: ✓" || echo "Pytest config: ✗"
command -v python3 &>/dev/null && echo "Python: $(python3 --version)" || echo "Python: ✗"

echo ""
echo "--- Contracts in Palantír ---"
[ -d docs/archive/contracts ] && ls docs/archive/contracts/ 2>/dev/null || echo "No contracts archived yet"

echo ""
echo "--- Next Actions ---"
grep -A 5 "## Next Steps" QUEST_PROGRESS.md 2>/dev/null | grep "\- \[ \]"
