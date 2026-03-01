# 06-chain-and-ordering.md
EventDB Core - Chain and Ordering
Version: 0.1
Status: Draft


## 1. Chain Ordering Scope

This section defines deterministic Event ordering and Chain continuity rules.

## 2. Sequence Rule

For each `chain_id`:
- `sequence` MUST be a positive integer.
- `sequence` MUST be unique.
- `sequence` MUST increase monotonically.
- gap handling policy MUST be explicit; default policy is gap disallowed.

## 3. Previous Hash Rule

For Event `n > 1`, `prev_hash` MUST equal recomputed hash of Event `n-1`.
For Event `1`, `prev_hash` MUST be the defined genesis value.

## 4. Acceptance Rule

An Event MAY be accepted into verified Chain state only if:
- field validation succeeds;
- recomputed hash succeeds;
- `prev_hash` continuity succeeds;
- signature verification succeeds.

## 5. Rejection Rule

An Event MUST be rejected if ordering, hash linkage, or signature checks fail.
Rejected Event artifacts MUST NOT be used to advance trusted Chain state.
