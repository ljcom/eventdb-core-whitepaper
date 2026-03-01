# 10-anchoring-interface.md
EventDB Core - Anchoring Interface Specification
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Scope

This section defines normative interface behavior for optional Anchor publication and verification.

## 2. Optionality

Anchoring MAY be disabled.
Core integrity conformance MUST remain valid without Anchor artifacts.

## 3. Anchor Payload

Anchor payload MUST minimally include:
- `chain_id`
- `checkpoint_ref` (typically Seal reference)
- `commitment_hash`
- `anchor_time_local`
- `anchor_ref_external`

## 4. Publish Rule

Published `commitment_hash` MUST match local canonical commitment at `checkpoint_ref`.
If mismatch exists, publication MUST fail.

## 5. Verification Rule

Verifier MUST:
- recompute local expected commitment;
- retrieve external commitment by `anchor_ref_external`;
- compare exact hash equality;
- validate checkpoint binding context.

Anchor verification success MUST NOT be interpreted as business truth or legal validity.
