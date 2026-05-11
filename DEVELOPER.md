# Developer Guide — Radagast

## When to use

Invoke Radagast when the task involves Python: FastAPI or Django endpoints, data pipelines, ML models, automation scripts, CLI tools, or Pydantic contract definitions.

Gandalf routes here via `SIGNAL_PYTHON_TASK`. Radagast publishes API contracts to the Palantír and signals Beorn via `SIGNAL_API_CONTRACT` when defining endpoints that Node.js will consume.

## Activating in a project

### With Claude Code

Add to your project `CLAUDE.md`:

```markdown
## Radagast — Python Agent

Before any Python decision, read:
- `<path-to-radagast>/packages/radagast/plugin/skills/radagast/SKILL.md`

Palantír second brain:
- Architecture / ADR → `<path-to-palantir>/skills/architecture/SKILL.md`
- Code review → `<path-to-palantir>/skills/code-review/SKILL.md`
- Debugging → `<path-to-palantir>/skills/debugging/SKILL.md`
- Refactoring → `<path-to-palantir>/skills/refactoring/SKILL.md`
- Test planning → `<path-to-palantir>/skills/testing/SKILL.md`
```

Or open a session inside `agents/radagast/` — the `CLAUDE.md` already wires everything.

## Bootstrap

```bash
./scripts/wizard-bootstrap.sh
```

Checks: Git, AGENT.md, QUEST_PROGRESS.md, contexto.md, virtual environment, requirements file, pytest, mypy/pyright strict mode.

## Operating sequence

1. **Palantír check** — consult existing contracts before defining new types or endpoints
2. **Type contract** — define Pydantic models or dataclasses for all inputs/outputs before implementation
3. **Publish contract** — if creating a new API endpoint, publish the contract before consumers build; signal Beorn via `SIGNAL_API_CONTRACT`
4. **Tests first** — pytest test file before any implementation
5. **Implement** — pure functions at the core, I/O at the edges; no `Any`, no bare `except`
6. **Mithril Armor** — scan for secrets, `eval`, `exec`, SQL injection before signaling Boromir
7. **Signal Boromir** — `SIGNAL_PYTHON_REVIEW_REQUEST` with artifacts and contracts

## Scripts

| Script | Command | Purpose |
|--------|---------|---------|
| Bootstrap | `./scripts/wizard-bootstrap.sh` | Load context and check harness health |
| Mirror | `python3 scripts/wizard-mirror.py` | Self-audit quality before delivery |
| Mithril Armor | `python3 scripts/mithril-armor.py` | Scan for secrets, `eval`, `exec`, SQL injection, `Any` types |
| Gates of Argonath | `cp scripts/gates-of-argonath.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit` | Install git pre-commit hook |

## Mirror of Galadriel — audit criteria

Score must be ≥ 80% before signaling Boromir:

1. **Contract-First** — Pydantic/dataclass types defined for all inputs and outputs
2. **Strict Typing** — no `Any`, full mypy/pyright compliance
3. **Pure Core** — business logic in pure functions; I/O isolated at the edges
4. **Proof Before Alloy** — pytest tests cover happy path, edge cases, and failure cases
5. **Mithril Armor** — scan executed, no `eval`/`exec`, no hardcoded secrets, no SQL injection vectors

## Signal protocols

| Signal | From / To | Payload |
|--------|-----------|---------|
| `SIGNAL_PYTHON_TASK` | Gandalf → Radagast | `context`, `requirements`, `api_contracts?` |
| `SIGNAL_PYTHON_REVIEW_REQUEST` | Radagast → Boromir | `artifacts[]`, `contracts[]` |
| `SIGNAL_API_CONTRACT` | Radagast → Beorn | Python-defined endpoint contracts |
| `ACK_PYTHON_COMPLETE` | Radagast → Gandalf | `artifacts[]`, `contracts[]` |

## Output shape

Every Radagast delivery includes:

1. Type contracts (Pydantic / dataclass)
2. Test file (pytest)
3. Implementation
4. Published API contracts (if applicable, in `docs/archive/contracts/`)
5. Next step

## Core law

**Contract First. Types Second. Tests Third. Implementation Last.**

Never write a function without its type signature. Never merge without pytest passing. Never use `Any`.
