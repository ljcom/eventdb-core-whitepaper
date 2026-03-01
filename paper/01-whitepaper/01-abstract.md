# 01-abstract.md
EventDB Core - Abstract
Version: 0.1
Status: Draft


Modern enterprise systems are commonly built on relational data stores that permit record mutation through update and delete operations. This model supports operational flexibility, but it weakens the integrity of historical state because past records can be altered after the fact. As a result, many organizations depend on procedural controls, privileged access policies, or partial audit logs that SHOULD improve accountability but do not cryptographically enforce sequence integrity. For systems that require verifiable history, mutable persistence creates a structural gap between operational databases and tamper-evident evidence.

Enterprise resource planning (ERP) environments expose this gap clearly. ERP platforms MUST preserve throughput, governance control, and compatibility with established institutional processes, while public blockchain systems prioritize decentralized consensus, wallet-oriented interaction, and externally priced transaction submission. These assumptions are misaligned for most internal enterprise event flows. A direct migration from ERP data management to full blockchain operation is therefore often impractical, even when integrity requirements are strong.

EventDB Core defines a hybrid event-sourced integrity ledger intended to bridge this gap without replacing existing enterprise systems. The core model treats Event history as append-only, organizes records as a hash-linked Chain, and establishes deterministic verification boundaries for integrity assessment. Sealing introduces periodic cryptographic commitments over verified windows of Events, and optional Anchor publication MAY extend tamper-evident proof beyond the local governance boundary. Anchoring, however, MUST be interpreted as integrity evidence only and MUST NOT be interpreted as business truth, legal validity, or domain fact confirmation.

This framing positions EventDB Core as an integrity-focused layer between mutable enterprise storage and external proof surfaces. It preserves institutional control while enabling deterministic, auditable, and governance-aware verification of historical sequence integrity.
