# 02-introduction.md
EventDB Core - Introduction
Version: 0.1
Status: Draft


Enterprise systems require both operational flexibility and verifiable historical integrity. Conventional databases optimize mutable state management, while integrity assurance needs immutable, reproducible sequence verification. EventDB Core addresses this mismatch by defining a deterministic integrity layer that can coexist with institutional systems.

The core model uses append-only Event recording, hash-linked Chain continuity, accountable signatures, periodic Seal checkpoints, and optional external Anchor publication. These mechanisms are designed to provide tamper-evident evidence without requiring full migration to external consensus infrastructure.

EventDB Core is governance-aware. Each institution retains explicit control over Account authority, verification policy, retention obligations, and operational procedures. The model supports federated verification between institutions without requiring a mandatory global ledger.

The scope of this whitepaper is conceptual and architectural. It defines what integrity proof means within EventDB Core and what it does not mean. Integrity proof covers sequence continuity, tamper evidence, and signer accountability. It does not prove business truth, legal validity, or physical-world authenticity.

The specification documents provide normative rules for canonical hashing, signature validation, Chain ordering, window sealing, Snapshot derivation, and Anchor verification. Implementation documents provide storage and operations guidance while preserving logical equivalence requirements defined by the core.
