# 11-verification-protocol.md
EventDB Core - Verification Protocol
Version: 0.1
Status: Draft


## 1. Scope

This section defines the normative verification protocol for EventDB Core.
All verification outcomes MUST be deterministic for equivalent input under canonical rules.

## 2. Preconditions

Before executing any verification flow, a verifier MUST:

1. Load active specification version and policy profile.
2. Load canonical hashing and signature rules.
3. Resolve trusted Account key material for the target governance boundary.
4. Reject verification if required inputs are missing or version-incompatible.

## 3. Event Chain Verification

A verifier MUST execute Event Chain verification as follows:

1. Select target `namespace_id`, target `chain_id`, and ordered Event set.
2. Confirm each Event contains all required fields per `03-spec/03-event-envelope.md`.
3. Validate field formats for each Event.
4. Ensure all selected Events belong to the same `namespace_id`.
5. Reject mixed-namespace Event streams.
6. For each Event, build canonical hash input excluding `signature`.
7. Canonicalize input and compute Event hash using active hashing rule.
8. For genesis Event, verify `prev_hash` equals the defined genesis value.
9. For each non-genesis Event, verify `prev_hash` equals hash of the immediately prior Event by `sequence`.
10. Verify monotonic, gap-free `sequence` progression for the verified segment.
11. Verify `signature` of each Event against canonical input and `account_id`.
12. Mark Event Chain verification as `PASS` only if all checks pass.
13. Mark Event Chain verification as `FAIL` if any check fails.

## 4. Seal Verification

A verifier MUST execute Seal verification as follows:

1. Select target `namespace_id`, target `chain_id`, and ordered Seal set.
2. Confirm each Seal contains required fields per `03-spec/07-window-and-seal.md`.
3. Validate all Seals in scope belong to the same `namespace_id`.
4. Validate Seal window boundaries and non-overlap requirements.
5. For each Seal, recompute `window_commitment_hash` from Events in the declared window range.
6. Ensure window Events are namespace-consistent with selected `namespace_id`.
7. Build canonical Seal input for hash coverage.
8. Canonicalize and recompute `seal_hash`.
9. For first Seal, verify `prev_seal_hash` equals genesis value.
10. For each subsequent Seal, verify `prev_seal_hash` equals prior `seal_hash` in deterministic order.
11. Verify Seal `signature` against canonical Seal input and `account_id`.
12. Mark Seal verification as `PASS` only if all checks pass.
13. Mark Seal verification as `FAIL` if any check fails.

## 5. Snapshot Verification

A verifier MUST execute Snapshot verification as follows:

1. Select target Snapshot and associated `chain_id` context.
2. Confirm Snapshot metadata references a specific Chain point and verification basis.
3. Verify referenced Chain and Seal artifacts are present and valid.
4. Recompute expected Snapshot state from referenced verified Chain/Seal context using deterministic rules.
5. Compare recomputed state with provided Snapshot representation.
6. Verify Snapshot has not replaced or invalidated underlying Event or Seal evidence.
7. Mark Snapshot verification as `PASS` only if all checks pass.
8. Mark Snapshot verification as `FAIL` if any check fails.

A Snapshot MUST NOT be accepted as authoritative if underlying Chain/Seal verification has failed or is incomplete.

## 6. Anchor Verification

A verifier MUST execute Anchor verification as follows:

1. Select target Anchor record and associated `chain_id`/Seal reference.
2. Verify local Chain and Seal context for the target checkpoint is valid.
3. Recompute expected anchor commitment from local canonical artifacts.
4. Retrieve external Anchor evidence for the claimed publication record.
5. Verify retrieved external commitment matches expected commitment exactly.
6. Verify Anchor context binding (Chain reference, Seal reference, and checkpoint identity) is consistent.
7. Verify external publication timestamp is present and policy-valid.
8. Mark Anchor verification as `PASS` only if all checks pass.
9. Mark Anchor verification as `FAIL` if any check fails.

Anchor verification success MUST be interpreted as consistency of published integrity evidence, not as business truth or legal validity.

## 7. Result Handling

A conforming verifier MUST:

1. Emit explicit result status for each verification scope: `PASS` or `FAIL`.
2. Record failure step and failure reason deterministically.
3. Preserve verification logs as auditable artifacts under governance policy.
4. Prevent promotion of `FAIL` artifacts into trusted integrity state.

## 8. Conformance Requirements

An implementation MUST be considered non-conformant if it:

1. Skips mandatory verification steps.
2. Accepts artifacts with unresolved hash, linkage, or signature mismatch.
3. Accepts Snapshot artifacts without verified Chain/Seal basis.
4. Accepts Anchor artifacts without deterministic local-to-external commitment match.
5. Produces non-deterministic outcomes for equivalent verification input.
