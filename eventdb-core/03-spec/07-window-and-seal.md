# 07-window-and-seal.md
EventDB Core - Window and Seal Specification
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Scope

This section defines normative rules for windowing and Seal processing in EventDB Core.
All conforming implementations MUST apply these rules deterministically.

## 2. Window Identifier

Each window MUST have a deterministic identifier `window_id`.

`window_id` MUST be uniquely derived from the following tuple:

- `chain_id`
- `window_start_sequence`
- `window_end_sequence`

Rules:

- `window_start_sequence` MUST be less than or equal to `window_end_sequence`.
- A window MUST represent a contiguous Event sequence range.
- For a given `chain_id` and sequence range, `window_id` MUST be identical across verifiers.
- Two distinct windows in the same `chain_id` MUST NOT share the same `window_id`.

## 3. Seal Creation Trigger

Seal creation MUST be triggered by deterministic policy.

A conforming policy MUST define one or more explicit trigger conditions, such as:

- sequence-count boundary;
- time boundary;
- governance-issued close signal.

Trigger rules MUST satisfy:

- trigger evaluation MUST be reproducible for the same Chain state;
- overlapping windows MUST NOT be emitted for the same trigger cycle;
- once a window is closed by trigger, its Event set MUST be immutable for Seal computation.

If trigger conditions are not satisfied, Seal creation MUST NOT occur.

## 4. Seal Structure

A Seal object MUST include at least:

- `chain_id`
- `window_id`
- `window_start_sequence`
- `window_end_sequence`
- `prev_seal_hash`
- `seal_hash`
- `account_id`
- `seal_time`
- `signature`

Additional fields MAY exist but MUST NOT alter canonical hash coverage defined in this section.

## 5. `prev_seal_hash` Linkage

`prev_seal_hash` MUST link Seals in strict order within one `chain_id`.

Rules:

- For the first Seal in a Chain, `prev_seal_hash` MUST be the defined genesis value.
- For every subsequent Seal, `prev_seal_hash` MUST equal the `seal_hash` of the immediately previous Seal.
- Seal order MUST be deterministic and MUST align with non-overlapping window progression.

Any break in `prev_seal_hash` continuity MUST cause Seal verification failure.

## 6. Seal Hash Computation

`seal_hash` MUST be computed from canonical Seal input `S`.

`S` MUST include exactly:

- `chain_id`
- `window_id`
- `window_start_sequence`
- `window_end_sequence`
- `prev_seal_hash`
- `window_commitment_hash`
- `account_id`
- `seal_time`

Definitions:

- `window_commitment_hash` MUST be the deterministic commitment over all Events in the window range, in canonical Chain order.
- Canonicalization and encoding rules for `S` MUST follow `03-spec/04-hashing-rule.md`.
- Default hash algorithm for `seal_hash` MUST be SHA-256 unless explicitly version-governed otherwise.

Computation:

- Build canonical object `S`.
- Serialize `S` to canonical JSON.
- Encode canonical JSON as UTF-8.
- Compute `seal_hash = H(S)`.

Any change to any covered field in `S` MUST change `seal_hash`.

## 7. Signature Rule

`signature` MUST be generated over canonical `S`.

Verification MUST fail if:

- signature input differs from canonical `S`;
- signature does not validate against `account_id`;
- `account_id` is invalid under active governance policy.

Signature algorithm behavior is defined in `03-spec/05-signature-rule.md`.

## 8. Verification Rule

A verifier MUST execute the following steps in order:

1. Validate required Seal fields and formats.
2. Validate window boundary consistency and contiguity assumptions.
3. Recompute `window_commitment_hash` from Events in `[window_start_sequence, window_end_sequence]`.
4. Build canonical `S` and recompute `seal_hash`.
5. Validate `prev_seal_hash` continuity against prior Seal in the same `chain_id`.
6. Verify `signature` over canonical `S` using `account_id`.
7. Accept Seal only if all checks pass.

If any step fails, the Seal MUST be rejected as invalid.

## 9. Conformance Requirements

An implementation MUST be considered non-conformant if it:

- creates non-deterministic `window_id` values;
- emits Seals for non-contiguous or mutable window ranges;
- accepts invalid `prev_seal_hash` linkage;
- computes `seal_hash` from non-canonical input;
- accepts Seals with invalid signature or unresolved window commitment mismatch.
