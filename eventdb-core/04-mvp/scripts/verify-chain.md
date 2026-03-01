# verify-chain.md
EventDB Core MVP Script Notes - Verify Chain
Version: 0.1
Status: Draft

## Objective

Verify deterministic Event continuity for a target Chain scope.

## Steps

1. Load ordered Events by `sequence`.
2. Recompute each Event hash from canonical input.
3. Validate `prev_hash` linkage for each Event.
4. Validate Event signature for each Event.
5. Return PASS only when all checks pass.

## Output

Verifier SHOULD return:
- status (`PASS` or `FAIL`)
- failed sequence (if any)
- error code from `03-spec/12-error-codes.md`
