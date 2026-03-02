# sample-verification-walkthrough.md
EventDB Core - Sample Verification Walkthrough
Version: 0.1
Status: Draft


This walkthrough describes a conceptual verification flow for an EventDB Chain. The objective is deterministic integrity verification: equivalent input MUST produce equivalent verification outcomes.

## 1. Event Loading

1. Identify target `chain_id` and verification scope (full history or bounded range).
2. Load Events in deterministic order by sequence.
3. Confirm each Event includes required envelope fields.
4. Reject the verification session if required fields are missing or input order is ambiguous.

## 2. Event Hash Recomputation

1. For each Event, build canonical hash input from required covered fields excluding `signature`.
2. Canonicalize input using the active canonical JSON rule.
3. Encode canonical input as UTF-8.
4. Recompute Event hash using the active hash rule.
5. Record recomputed hash for subsequent linkage checks.

Verification logic: if canonicalization or hash recomputation is non-deterministic, integrity claims are invalid.

## 3. Chain Linkage Verification

1. Validate genesis Event `prev_hash` against the defined genesis value.
2. For each non-genesis Event, compare stored `prev_hash` with recomputed hash of the immediately previous Event.
3. Validate sequence monotonicity and gap-free progression in the verified scope.
4. Verify Event signature against canonical covered input and `account_id`.
5. Mark Chain verification as failed if any linkage, sequence, or signature mismatch is found.

Verification logic: Chain integrity depends on uninterrupted hash and signature consistency across ordered Events.

## 4. Seal Verification

1. Load Seals in deterministic order for the target Chain.
2. For each Seal, confirm declared window boundaries and required Seal fields.
3. Recompute window commitment from Events in the declared window range.
4. Recompute `seal_hash` from canonical Seal input.
5. Verify `prev_seal_hash` continuity against prior Seal.
6. Verify Seal signature against canonical Seal input and `account_id`.

Verification logic: Seals provide checkpoint commitments; invalid Seal continuity indicates integrity checkpoint failure.

## 5. Snapshot Verification (If Exists)

1. Confirm Snapshot references a specific verified Chain point.
2. Recompute expected Snapshot state from verified Chain and Seal context.
3. Compare recomputed state with provided Snapshot representation.
4. If mismatch exists, treat Snapshot as invalid and continue from underlying Chain evidence.

Verification logic: Snapshot is a performance artifact and MUST remain derivable from verified history.

## 6. Anchor Verification (If Exists)

1. Identify the local Seal or checkpoint commitment to be validated externally.
2. Recompute expected anchor commitment from local canonical artifacts.
3. Retrieve corresponding external Anchor evidence.
4. Compare external commitment with recomputed local commitment.
5. Validate context binding (Chain reference, checkpoint reference, and timestamp context).

Verification logic: Anchor verification confirms external publication consistency for integrity evidence. It does not prove business truth or legal validity.

## Verification Outcome Rule

1. Report `PASS` only if all applicable checks succeed for the selected scope.
2. Report `FAIL` if any mandatory check fails.
3. Record failure step and reason deterministically for audit and review.

## Sample Artifact Note

For the published sample set in `paper/05-mvp/sample`:

- namespace scope is `default`;
- `prev_hash`, `window_commitment_hash`, `seal_hash`, and `snapshot_hash` are aligned with canonical SHA-256 recomputation;
- expected verification outcome is `PASS` for chain/seal/snapshot when `SIGNATURE_MODE=none`.
