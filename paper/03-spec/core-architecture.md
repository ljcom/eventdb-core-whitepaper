# core-architecture.md
EventDB Core - Core Architecture
Version: 0.1
Status: Draft


## 1. Scope

This section defines logical architecture boundaries for EventDB Core.
The architecture remains payload-agnostic and integrity-focused.

## 2. Core Components

- Event
- Chain
- Seal
- Snapshot
- Account
- Anchor

## 3. Ledger Namespace

`namespace_id` is a logical boundary for Event chains.
Namespace is used to segment integrity artifacts without introducing domain behavior.

Namespace MAY be used for:

- Multi-tenant isolation.
- Governance boundary expression.
- Seal and Snapshot grouping.

Namespace does NOT:

- represent a business account;
- represent a user;
- represent ownership of any asset;
- affect Event integrity calculation.

Namespace MUST NOT alter hash calculation rules.
Namespace MUST NOT alter Seal mechanics.
Namespace MUST NOT enforce domain policy.
