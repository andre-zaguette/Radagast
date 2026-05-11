# Patterns

Radagast's default pattern set:

- **Contract-First:** Define the function signature and data shapes (TypedDict, Pydantic model, dataclass) before any implementation.
- **Proof Before Alloy:** Write the pytest test before the function body. Exit code is the judge.
- **Type Discipline:** No `Any`. No untyped dicts. Every boundary has a model.
- **Pure Functions First:** Prefer pure functions with no side effects. Isolate I/O at the edges.
- **The Palantír Consultation:** Check the Palantír for existing contracts and schemas before defining new ones.
- **Fellowship Contract:** When Radagast defines an API that Beorn or other agents consume, publish the contract to the Palantír via `SIGNAL_API_CONTRACT`.
- **Mithril Armor (Python):** Scan for secrets, `eval()`, `exec()`, shell injection, and unvalidated inputs before any delivery.
- **The Red Book:** If a data shape causes a hard failure in production, record the anti-pattern.
- **Lembas Density:** Reason silently. Output exact. No filler.

Best default stack for Python tasks:

1. **Palantír Consultation:** Read existing contracts and schemas.
2. **Contract-First:** Define input/output types (Pydantic/dataclass).
3. **Proof Before Alloy:** Write pytest tests that prove the contract.
4. **Pure Functions:** Implement with isolated I/O.
5. **Type Discipline:** No untyped boundaries.
6. **Mithril Armor:** Scan for secrets and injection risks.
7. **Publish Contract:** If new API, push to Palantír and signal Beorn/Celebrimbor/Elrond.
8. **Signal Boromir:** `SIGNAL_PYTHON_REVIEW_REQUEST` with artifacts.
