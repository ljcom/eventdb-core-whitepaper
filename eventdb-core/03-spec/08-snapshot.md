# 08-snapshot.md
EventDB Core - Snapshot Specification
Version: 0.1
Status: Draft


## 1. Scope

This section defines normative Snapshot behavior.

## 2. Snapshot Purpose

Snapshot MUST represent derived state from verified Chain/Seal context.
Snapshot is a performance artifact and MUST NOT replace underlying history.

## 3. Required Snapshot Metadata

A Snapshot MUST include:
- `chain_id`
- `snapshot_id`
- `basis_sequence`
- `basis_seal_hash` (if Seal exists at basis)
- `snapshot_time`
- `snapshot_hash`
- `signature`

## 4. Derivation Rule

Snapshot state MUST be reproducible from verified artifacts at `basis_sequence`.
If recomputation mismatch occurs, Snapshot MUST be rejected.

## 5. Verification Rule

Verifier MUST:
- verify basis Chain/Seal validity;
- recompute expected Snapshot representation;
- verify `snapshot_hash` and `signature`;
- fail verification on mismatch.
