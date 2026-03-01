# 03-event-envelope.md
EventDB Core - Event Envelope Specification
Version: 0.1
Status: Draft


## 1. Scope

This section defines the normative Event envelope for EventDB Core.
All conforming implementations MUST follow this specification.

## 2. Required Fields

An Event envelope MUST contain all fields below:

- `chain_id`
- `event_id`
- `sequence`
- `prev_hash`
- `account_id`
- `event_type`
- `event_time`
- `payload`
- `signature`

An Event envelope MUST NOT omit any required field.
An Event envelope MAY include additional non-canonical fields, but such fields MUST NOT affect canonical hashing, signature verification, or validation outcome.

## 2A. Optional Field

- `namespace_id` MAY be included as Event metadata.
- If present, `namespace_id` MUST be treated as immutable once the Event is recorded.
- `namespace_id` MUST represent a ledger boundary identifier only.
- `namespace_id` MUST NOT be interpreted as user identity, business account, or asset ownership marker.

## 3. Field Format Rules

### 3.1 `chain_id`

- MUST be a non-empty UTF-8 string.
- MUST be stable for the Chain context.
- MUST match exactly between producer and verifier.

### 3.2 `event_id`

- MUST be a non-empty UTF-8 string.
- MUST be unique within one `chain_id`.

### 3.3 `sequence`

- MUST be a positive integer.
- MUST increase monotonically within one `chain_id`.
- MUST be unique within one `chain_id`.

### 3.4 `prev_hash`

- MUST be a lowercase hexadecimal string, or the defined genesis value for the first Event in a Chain.
- For non-genesis Events, MUST equal the hash of the immediately previous Event by `sequence`.

### 3.5 `account_id`

- MUST be a non-empty UTF-8 string.
- MUST identify an accountable Account in the governance boundary.

### 3.6 `event_type`

- MUST be a non-empty UTF-8 string.
- MUST be deterministic for the issuing application context.

### 3.7 `event_time`

- MUST be an RFC 3339 timestamp string in UTC (`Z` suffix).
- MUST represent issuance time of the Event.

### 3.8 `payload`

- MUST be valid JSON object or JSON array.
- MUST be canonicalized before hashing as defined by canonical JSON rules.

### 3.9 `signature`

- MUST be a non-empty encoded signature value.
- MUST be verifiable against `account_id` and canonical signing input.

### 3.10 `namespace_id` (optional)

- MAY be omitted.
- If present, MUST be a non-empty UTF-8 string.
- If present, MUST remain unchanged for the recorded Event artifact.

## 4. Canonicalization Rule

Before hashing or signature verification, the Event envelope input MUST be canonicalized.
Canonicalization MUST produce one deterministic byte sequence for equivalent data.
Canonicalization MUST use UTF-8 and deterministic JSON key ordering.
Whitespace and serialization variations MUST NOT change canonical output.

## 5. Hash Coverage Rule

Hash input MUST cover all required fields except `signature`.

Let `E` be the canonical Event envelope object containing:

- `chain_id`
- `event_id`
- `sequence`
- `prev_hash`
- `account_id`
- `event_type`
- `event_time`
- `payload`

If `namespace_id` is present, it MUST be included in `E`.

Event hash MUST be computed as `H(E)`.
Any change in any covered field MUST change `H(E)`.
No non-canonical field MAY be included in `H(E)` coverage.

## 6. Signature Rule

Signature input MUST be the canonical representation of `E` used for `H(E)`.

A conforming signature process MUST satisfy:

- the signer key MUST correspond to `account_id`;
- the signature MUST be generated over canonical input;
- verification MUST fail if any covered field differs;
- verification MUST fail if `account_id` key mapping is invalid or revoked under policy.

Signature algorithm selection is defined in `03-spec/05-signature-rule.md`.
This section defines mandatory input scope and verification behavior.

## 7. Validation Steps

A verifier MUST execute validation in this order:

1. Confirm presence of all required fields.
2. Confirm each field format rule in Section 3, including optional `namespace_id` when present.
3. Build canonical object `E` from required fields excluding `signature`.
4. If `namespace_id` is present, include it in canonical object `E`.
5. Canonicalize `E` using deterministic JSON rules.
6. Compute `H(E)` and compare with expected chain continuity context.
7. Verify `prev_hash` linkage against prior Event by `sequence`.
8. Verify `signature` against canonical `E` and `account_id`.
9. Accept Event only if all prior steps pass.

If any step fails, the Event MUST be rejected as invalid for integrity verification.

## 8. Conformance Requirements

An implementation MUST be considered non-conformant if it:

- hashes non-canonical input;
- excludes any required covered field from hash input;
- accepts invalid `prev_hash` linkage;
- accepts unverifiable or mismatched signatures;
- allows field format deviations defined as mandatory in this section.
