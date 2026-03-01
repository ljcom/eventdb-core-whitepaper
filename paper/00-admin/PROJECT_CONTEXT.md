# PROJECT_CONTEXT.md
EventDB Core – Project Context
Version: 0.1
Status: Active Reference

---

## 1. Why EventDB Core Exists

Modern enterprise systems rely on databases that allow mutation:

- Records can be updated.
- Historical data can be overwritten.
- Audit trails are often optional or incomplete.

At the same time:

- Full blockchain adoption is impractical for most institutions.
- Regulatory environments demand accountability, not decentralization.
- Organizations need tamper-evident integrity without abandoning existing infrastructure.

EventDB Core exists to address this gap.

> It provides a hybrid integrity layer built on event-sourcing, hash chaining, and optional blockchain anchoring.

It is not a blockchain replacement.
It is not a tokenization engine.
It is an integrity enhancement framework.

---

## 2. Problem Landscape

### 2.1 Mutable Database Systems

Traditional relational databases:

- Allow UPDATE and DELETE
- Rely on trust in administrators
- Provide weak historical guarantees

Even with audit tables, integrity is not cryptographically enforced.

---

### 2.2 Blockchain Limitations

Public blockchain systems:

- Require wallet infrastructure
- Introduce gas costs
- Are unsuitable for high-frequency internal events
- Do not understand institutional governance

Enterprises rarely want full decentralization.
They want controlled integrity.

---

## 3. Strategic Positioning

EventDB Core is positioned as:

- A deterministic append-only ledger layer
- A hash-chained integrity mechanism
- A governance-aware design
- A blockchain-optional anchoring interface

It is compatible with:

- PostgreSQL
- MSSQL
- Traditional ERP systems
- Federated institutional environments

---

## 4. Scope of the Core

EventDB Core defines:

- Event envelope structure
- Canonical hashing rule
- Signature verification
- Chain ordering
- Window sealing
- Snapshot logic
- Anchoring interface

It does NOT define:

- Domain-specific events
- Supply chain logic
- Financial tokenization
- Marketplace behavior

Those belong to profile implementations.

---

## 5. Adoption Philosophy

EventDB Core follows:

- Federated-first design
- Institutional accountability
- Minimal cryptographic footprint
- Deterministic integrity

Blockchain anchoring is optional.

Integrity proof does not equal business truth.

---

## 6. Long-Term Vision

EventDB Core may serve as:

- Integrity layer for ERP systems
- Cross-organization verification mechanism
- Audit-ready ledger foundation
- Base for domain-specific profiles

It is designed to remain:

Minimal.
Deterministic.
Composable.
Governance-aware.