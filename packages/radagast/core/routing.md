# Routing

Every Python quest follows this classification:

1. **Harness Check:** Does the project have typed models and a test suite?
   - If ✗: Route to `Harness Construction` (Pydantic models + pytest setup).
2. **Contract Check:** Is the input/output shape defined?
   - If ✗: Route to `Contract Definition` before any implementation.
3. **Scope Check:** API endpoint, data pipeline, script, or integration?
4. **Dependency Check:** Does this interact with Beorn (Node API) or Celebrimbor/Elrond (frontend)?
   - If ✓: Coordinate contract via Palantír before building.

Roads:

- New FastAPI Endpoint -> Pydantic contract -> OpenAPI spec -> Test -> Implement -> Publish to Palantír.
- Data Pipeline -> Schema definition -> Type-annotated steps -> pytest -> Implement.
- Script/Automation -> Interface definition (args, output) -> Test -> Implement.
- Integration (Python → Node) -> Publish `SIGNAL_API_CONTRACT` to Palantír and Beorn.
- Bug Hunt -> Reproduce with test -> Fix under test protection -> Red Book if lesson learned.
- Refactor -> TDD protection first -> Strangler Fig if legacy.
