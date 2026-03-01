# 04-related-work.md
EventDB Core - Related Work
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

EventDB Core draws from three established design families: event sourcing, append-only audit logging, and cryptographic integrity ledgers. The model adopts deterministic sequence verification from integrity ledger practice while preserving operational compatibility expected in institutional systems.

Event sourcing contributes the principle that state transitions are represented as ordered Events rather than mutable in-place updates. EventDB Core aligns with this principle for integrity evidence but keeps domain semantics outside the core specification.

Traditional audit logging contributes accountability patterns, including actor attribution and timeline reconstruction. EventDB Core extends this by requiring deterministic canonical hashing and linkage checks, reducing dependence on procedural trust alone.

Cryptographic ledger systems contribute tamper-evidence through chained commitments and signed records. EventDB Core applies these properties within institution-governed boundaries and treats external anchoring as optional evidence extension, not as mandatory operational substrate.

Compared with monolithic global-ledger models, EventDB Core prioritizes federation by verification rather than federation by shared state. This distinction supports independent governance while enabling cross-boundary integrity checks.

The resulting architecture is a hybrid integrity layer: event-sourced, append-only, hash-chained, seal-enabled, and blockchain-optional. It is designed to remain minimal, deterministic, and governance-aware.
