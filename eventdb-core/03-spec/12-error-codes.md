# 12-error-codes.md
EventDB Core - Error Codes
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Error Model

Error codes are deterministic verification outcomes.
Each failure MUST map to one primary code.

## 2. Event and Chain Errors

- `EVT_REQUIRED_FIELD_MISSING`: required Event field absent.
- `EVT_FIELD_FORMAT_INVALID`: Event field format invalid.
- `EVT_CANONICALIZATION_FAILED`: canonical JSON generation failed.
- `EVT_HASH_MISMATCH`: recomputed Event hash mismatch.
- `CHAIN_PREV_HASH_INVALID`: `prev_hash` linkage invalid.
- `CHAIN_SEQUENCE_INVALID`: sequence order or uniqueness invalid.
- `EVT_SIGNATURE_INVALID`: Event signature validation failed.

## 3. Seal Errors

- `SEAL_REQUIRED_FIELD_MISSING`: required Seal field absent.
- `SEAL_WINDOW_INVALID`: window bounds or contiguity invalid.
- `SEAL_COMMITMENT_MISMATCH`: window commitment hash mismatch.
- `SEAL_PREV_HASH_INVALID`: `prev_seal_hash` linkage invalid.
- `SEAL_SIGNATURE_INVALID`: Seal signature invalid.

## 4. Snapshot Errors

- `SNAPSHOT_REFERENCE_INVALID`: basis reference missing or invalid.
- `SNAPSHOT_DERIVATION_MISMATCH`: recomputed snapshot state mismatch.
- `SNAPSHOT_SIGNATURE_INVALID`: snapshot signature invalid.

## 5. Anchor Errors

- `ANCHOR_REFERENCE_NOT_FOUND`: external anchor reference unavailable.
- `ANCHOR_COMMITMENT_MISMATCH`: external and local commitment differ.
- `ANCHOR_CONTEXT_INVALID`: chain/checkpoint binding mismatch.
- `ANCHOR_TIMESTAMP_INVALID`: external timestamp missing or policy-invalid.
