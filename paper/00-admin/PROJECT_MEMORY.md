# PROJECT_MEMORY.md
EventDB Core – Architectural Memory
Version: 0.1
Status: Binding Design Memory

---

## 1. Core Identity

EventDB Core is:

- Event-sourced
- Append-only
- Hash-chained
- Seal-enabled
- Blockchain-optional

If any future feature contradicts these principles, it must be reconsidered.

---

## 2. Non-Negotiable Rules

1. Events are immutable.
2. Each event references the previous hash.
3. Seals reference previous seals.
4. Snapshots do not rewrite history.
5. Anchoring does not define business truth.
6. Governance boundary must be explicit.
7. Namespace is a ledger boundary, not a business entity.

---

## 3. Terminology Stability

Core terms must remain stable:

- Event
- Chain
- Seal
- Snapshot
- Account
- Anchor

Do not introduce alternative naming without strong reason.

---

## 4. Integrity Definition

Integrity means:

- Sequence immutability
- Tamper evidence
- Signer accountability

Integrity does NOT mean:

- Legal validity
- Asset authenticity
- Physical truth

---

## 5. Design Philosophy

### 5.1 Determinism Over Flexibility

Integrity systems must avoid ambiguity.

All hashing rules must be canonical.
All signature rules must be explicit.

---

### 5.2 Federation Over Centralization

Each institution controls its own chain.

No mandatory shared ledger.

---

### 5.3 Minimal Cryptography

Use cryptography only for:

- Hash
- Signature
- Anchor proof

Avoid over-engineering.

---

## 6. Snapshot Philosophy

Snapshots:

- Improve performance
- Reduce verification cost
- Must remain verifiable

Archival ≠ deletion of integrity proof.

---

## 7. Anti-Drift Reminder

EventDB Core must never drift into:

- Token issuance platform
- Crypto branding
- Marketplace logic
- Financial instrument narrative

It is an integrity engine.
