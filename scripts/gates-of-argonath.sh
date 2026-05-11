#!/bin/bash
# The Gates of Argonath: Git Pre-commit Hook

echo "🛡️ The Gates of Argonath: Inspecting the Caravan..."

# 1. Check Progress Log
if [ ! -f QUEST_PROGRESS.md ]; then
    echo "❌ ERROR: QUEST_PROGRESS.md is missing. No code shall pass without a record."
    exit 1
fi

# 2. Check if Progress was updated
if ! git diff --cached --name-only | grep -q "QUEST_PROGRESS.md"; then
    echo "⚠️ WARNING: QUEST_PROGRESS.md not staged. Did you record this quest's steps?"
fi

# 3. Run Mithril Armor scan
if [ -f scripts/mithril-armor.py ]; then
    python3 scripts/mithril-armor.py
    if [ $? -ne 0 ]; then
        echo "❌ Mithril Armor failed. Fix shadows before passing the Gates."
        exit 1
    fi
fi

# 4. Check Archive freshness
if [ -d docs/archive ]; then
    CODE_CHANGED=$(git diff --cached --name-only | grep -E "\.(py|js|ts|vue|tsx|jsx)$")
    ARCHIVE_CHANGED=$(git diff --cached --name-only | grep "docs/archive/")
    if [ -n "$CODE_CHANGED" ] && [ -z "$ARCHIVE_CHANGED" ]; then
        echo "📜 The Palantír Map may be out of date. Consider updating docs/archive/."
    fi
fi

echo "✅ The Gates are open. Pass, traveler."
exit 0
