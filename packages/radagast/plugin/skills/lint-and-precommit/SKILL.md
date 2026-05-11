---
name: lint-and-precommit
description: Python lint and pre-commit quality gate. Use before every commit on a Radagast project. Runs Ruff (lint + format), mypy (strict type check), and pytest (fast unit pass) on staged files. Blocks the commit if any check fails.
---

# Skill: Lint and Pre-commit — Radagast (Python)

## When to use

Run before every commit on a Python project. This skill enforces:
- Ruff lint rules (replaces flake8, isort, pyupgrade, bandit subset)
- Ruff format (replaces black)
- mypy strict type checking
- pytest fast pass (`-x`, stop at first failure) on staged modules

## Setup

### 1. Install dependencies

```bash
pip install ruff mypy pytest
# or add to pyproject.toml / requirements-dev.txt
```

### 2. Copy config templates

```bash
cp scripts/lint-templates/pyproject.toml .         # ruff + mypy config
cp scripts/lint-templates/.pre-commit-config.yaml .  # pre-commit framework (optional)
```

### 3. Install the pre-commit hook (script-based)

```bash
cp scripts/gates-of-argonath.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

### 4. Or use pre-commit framework

```bash
pip install pre-commit
pre-commit install   # installs from .pre-commit-config.yaml
```

## Procedure

The `scripts/lint.sh` runs automatically via the pre-commit hook:

1. Detect staged `.py` files
2. Run `ruff check --fix` on staged files
3. Run `ruff format` on staged files
4. Run `mypy` on staged files (strict mode)
5. Run `pytest -x --tb=short -q` on test files related to staged modules
6. Re-stage auto-fixed files
7. Block commit if any step fails

## Rules enforced (Ruff)

| Category | Rules |
|----------|-------|
| `E`, `W` | pycodestyle errors and warnings |
| `F` | pyflakes (unused imports, undefined names) |
| `I` | isort (import ordering) |
| `N` | pep8-naming conventions |
| `UP` | pyupgrade (modern Python syntax) |
| `B` | flake8-bugbear (common bugs) |
| `S` | flake8-bandit (security subset) |
| `ANN` | type annotation enforcement |

## mypy config (strict)

```toml
[tool.mypy]
strict = true
python_version = "3.10"
disallow_any_explicit = true
```

## Output

- Auto-fixed files re-staged
- mypy errors printed to stderr with line numbers
- Commit blocked on any error
