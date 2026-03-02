# walkthrough.md
EventDB Core MVP Demo Walkthrough
Version: 0.1
Status: Draft

## Flow

1. Load sample Events from `sample-events.jsonl`.
2. Recompute Event hashes and validate `prev_hash` continuity.
3. Validate Event signatures.
4. Load sample Seal and verify window commitment plus `prev_seal_hash`.
5. Load sample Snapshot and verify derivation against Chain basis.
6. If Anchor record exists, verify external commitment consistency.

## Expected Result

For the current MVP sample artifacts under `paper/05-mvp/sample`:

- Chain verification: `PASS`
- Seal verification: `PASS`
- Snapshot verification: `PASS`
- Anchor verification: `FAIL` (adapter not implemented in MVP)

Assumption: verifier runs with `SIGNATURE_MODE=none` (default in MVP).
