# 06-architecture-overview.md
EventDB Core - Architecture Overview
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

EventDB Core defines a layered integrity architecture for enterprise Event history. The architecture is logical and verification-oriented: it specifies how integrity evidence is produced and validated, independent of any single storage engine. The core objective is deterministic tamper evidence with explicit governance boundaries.

This document describes the conceptual and verification layers only. Storage layout, indexing strategy, and vendor-specific persistence patterns belong to implementation documentation and MUST remain outside this overview.

## Ledger Boundary

A ledger boundary defines the scope within which Chain continuity, Seal checkpoints, and Account authority operate.
Each Chain MUST exist within exactly one ledger boundary.
Federation occurs between ledger boundaries.
A ledger boundary MAY correspond to an institution, tenant, or deployment unit.
A ledger boundary MUST NOT be interpreted as domain classification (for example, commodity type or asset class).

## Conceptual Layer

The conceptual layer defines the core semantics of EventDB Core and the boundaries of claims.

- An Event represents an immutable recorded fact within the system boundary.
- A Chain represents the ordered integrity sequence formed by linked Events.
- A Seal represents a cryptographic commitment over a bounded Event window.
- A Snapshot represents a derived checkpoint used to reduce verification or operational cost without rewriting history.
- An Account represents an identifiable signing authority operating under institutional governance.
- An Anchor represents optional external publication of integrity evidence.

At this layer, integrity claims MUST remain bounded: the architecture proves sequence continuity, tamper evidence, and signer accountability. It MUST NOT claim business truth, legal validity, or domain correctness.

## Chain Layer

The Chain layer is the primary continuity mechanism.

Each Event MUST be linked to prior chain state through deterministic hash linkage. This creates a verifiable sequence in which omission, insertion, or reordering attempts can be detected through re-verification. Chain verification MUST produce the same result for all compliant verifiers given identical Event inputs and canonical rules.

The Chain layer also defines accountability boundaries. Events SHOULD be associated with accountable Accounts so that sequence integrity and signer responsibility can be evaluated together. This does not require centralized control across all institutions; it requires explicit governance within each participating boundary.

The Chain layer is logical and independent from physical persistence. A Chain MAY be stored in relational tables, log files, object storage, or hybrid patterns, provided the canonical verification rules are preserved.

## Seal Layer

The Seal layer introduces periodic commitments over bounded segments of Chain history.

A Seal MUST commit to a defined Event window and MUST be verifiable against the corresponding chain segment. Seals SHOULD be generated at operationally meaningful intervals to reduce verification scope for long histories and to produce stable integrity checkpoints.

Seal continuity MUST also be verifiable. Where multiple Seals exist, the sequence of Seals SHOULD support detection of missing windows or inconsistent commitments. Institutional signing of Seals MUST be attributable to accountable Accounts so that integrity checkpoints are auditable within governance policy.

The Seal layer is not a replacement for Event-level verification. It is a compression boundary for integrity evidence. Full verification MAY still require Event-level re-checking where policy demands deeper inspection.

## Snapshot Layer

The Snapshot layer provides derived checkpoints to improve operational efficiency while preserving integrity semantics.

A Snapshot SHOULD summarize verified chain state at a known point so that systems can avoid replaying full history for every read or verification task. However, Snapshot generation MUST be traceable to verified Chain and Seal state, and Snapshot use MUST NOT rewrite prior Event records.

Snapshots are performance artifacts, not authoritative replacements for history. If a Snapshot is missing, stale, or disputed, the underlying Chain and Seal evidence MUST remain sufficient for deterministic re-verification.

This layer enables scale without weakening integrity boundaries: archival and retention policies MAY move historical payloads across storage tiers, but integrity proof continuity MUST remain preserved.

## Anchoring Interface

The anchoring interface defines how integrity evidence can be published to an external proof surface.

Anchoring is optional. Core integrity verification MUST function without any external Anchor. When used, anchoring SHOULD publish bounded commitments (for example, Seal-related evidence) rather than operational payload data. This preserves governance control while extending tamper-evident visibility beyond local infrastructure.

The anchoring interface MUST be implementation-agnostic at the core specification level. Specific Anchor adapters, network choices, and submission procedures are implementation concerns and belong to adapter documentation.

Anchor evidence strengthens tamper-evident claims across boundaries but MUST NOT be interpreted as business truth or legal validity.

## Logical Architecture Versus Storage Implementation

EventDB Core intentionally separates integrity logic from persistence engineering.

Logical architecture defines:

- Canonical Event and Chain semantics
- Deterministic verification behavior
- Seal and Snapshot integrity roles
- Governance-aware signing accountability
- Optional Anchor interaction boundaries

Storage implementation defines:

- Physical data models
- Indexing and partitioning
- Query optimization
- Backup and operational procedures
- Vendor-specific integration patterns

An implementation MAY optimize storage aggressively, but it MUST preserve logical integrity equivalence. If two implementations claim EventDB Core conformance, they MUST produce equivalent verification outcomes for the same Event, Chain, Seal, Snapshot, and Anchor evidence under canonical rules.

This separation ensures portability across enterprise SQL environments while maintaining stable integrity semantics at the core layer.
