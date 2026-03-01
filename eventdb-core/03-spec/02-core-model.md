# 02-core-model.md
EventDB Core - Core Model
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Model Statement

EventDB Core is an append-only, event-sourced, hash-chained integrity model with Seal checkpoints and optional Anchor publication.
A conforming implementation MUST preserve deterministic verification outcomes for equivalent input.

## 2. Core Components

- `Event`: immutable atomic record.
- `Chain`: ordered Event sequence with previous-hash linkage.
- `Seal`: window commitment linked by previous-seal hash.
- `Snapshot`: derived checkpoint from verified history.
- `Account`: accountable signing identity.
- `Anchor`: optional external commitment publication.

## 3. Model Invariants

- Events MUST be immutable after acceptance.
- Chain order MUST be deterministic.
- Hash and signature verification MUST use canonical input.
- Seals MUST reference deterministic windows.
- Snapshots MUST be derivable from verified artifacts.
- Anchoring MUST remain optional.

## 4. Non-Claims

The core model MUST NOT claim business truth, legal enforceability, or physical authenticity.

## 5. Ledger Namespace

`namespace_id` defines a logical ledger boundary for Event chains.
Namespace is a grouping and isolation construct for integrity operations.

Namespace MAY be used for:

- Multi-tenant isolation.
- Governance boundary expression.
- Seal and Snapshot grouping.

Namespace MUST NOT be interpreted as:

- business account identity;
- user identity;
- ownership identity for any asset.

Namespace MUST NOT alter hash calculation rules.
Namespace MUST NOT alter Seal mechanics.
Namespace MUST NOT introduce business logic or domain policy enforcement.
