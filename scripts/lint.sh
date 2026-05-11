#!/bin/bash
# Radagast: Python Linter — runs on staged .py files only

set -e

STAGED=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.py$' || true)

if [ -z "$STAGED" ]; then
  echo "Radagast: No staged .py files. Skipping lint."
  exit 0
fi

echo "Radagast: Running Ruff lint..."
ruff check --fix $STAGED
if [ $? -ne 0 ]; then
  echo "Ruff lint failed. Fix errors before committing."
  exit 1
fi

echo "Radagast: Running Ruff format..."
ruff format $STAGED

echo "Radagast: Running mypy type check..."
mypy $STAGED
if [ $? -ne 0 ]; then
  echo "mypy type check failed. Fix type errors before committing."
  exit 1
fi

echo "Radagast: Running pytest (fast pass)..."
pytest -x --tb=short -q --ignore=tests/e2e
if [ $? -ne 0 ]; then
  echo "Tests failed. Fix failing tests before committing."
  exit 1
fi

# Re-stage auto-fixed files
git add $STAGED

echo "Radagast: Lint passed."
exit 0
