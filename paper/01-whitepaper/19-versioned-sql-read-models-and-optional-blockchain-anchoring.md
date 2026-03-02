# 19-versioned-sql-read-models-and-optional-blockchain-anchoring.md
EventDB Core - Versioned SQL Read Models and Optional Blockchain Anchoring
Version: 0.1
Status: Draft


This section defines an architectural extension that positions EventDB Core as verifiable infrastructure combining immutable event streams, deterministic projections, SQL read models, and optional cryptographic anchoring.

## 1. SQL Read Model Layer

EventDB Core stores immutable append-only Events in the integrity layer. Query-facing views are produced through deterministic projection from those Events.

Read models MAY be materialized as SQL tables optimized for `SELECT` workloads. These tables exist to improve access patterns for applications, analytics, and reporting, without changing integrity semantics.

Conceptual flow:

`Event -> Projection Engine -> SQL Table -> Query Layer`

Boundary rules:

- Read models are not the source of truth.
- Read models are derived state from the Event stream.
- `INSERT` or `UPDATE` in read tables MUST originate from projection execution.
- Direct manual modification of read tables is prohibited under integrity policy.

Read model utility:

- support indexing for low-latency query paths;
- support joins across domain-oriented query views;
- support reporting and BI integration;
- preserve deterministic rebuild behavior from canonical Event history.

Each read model MUST declare a projection version. Rebuild from Event replay MUST produce equivalent table state for the same projection version and input Event sequence.

Conceptual SQL and projection example:

```sql
-- Query model (derived state)
CREATE TABLE read.orders (
  order_id        text primary key,
  customer_id     text not null,
  status          text not null,
  total_amount    numeric(18,2) not null,
  updated_at      timestamptz not null,
  projection_ver  integer not null
);
```

```text
Projection rule (conceptual):
- on OrderCreated  -> INSERT read.orders
- on OrderUpdated  -> UPDATE read.orders status/total_amount/updated_at
- on OrderCanceled -> UPDATE read.orders status='canceled'
```

```sql
-- Query usage (read path only)
SELECT order_id, customer_id, status, total_amount
FROM read.orders
WHERE status = 'active'
ORDER BY updated_at DESC;
```

## 2. Projection Versioning

Each read model template MUST have an explicit version number. Any change in projection logic, field derivation rule, or normalization behavior MUST increment projection version.

Projection evolution strategies:

- Full rebuild: replay all relevant Events into a new projection version.
- Incremental migration: transform existing read model state with bounded replay and deterministic migration rules.
- Snapshot-assisted rebuild: use verified checkpoints to reduce replay range while preserving deterministic equivalence.

Projection versioning is critical for long-lived enterprise systems because schema and policy evolution is unavoidable. It is also critical in regulatory environments because historical projection logic must remain auditable at specific points in time. Backward compatibility depends on the ability to operate multiple projection versions during transition windows.

## 3. Cryptographic Anchoring (Optional Layer)

EventDB Core is logically immutable by append-only design. However, privileged operators at storage level may still attempt unauthorized modification. EventDB Core therefore supports optional cryptographic anchoring as a tamper-evident integrity layer.

Conceptual mechanism:

- each Event produces a deterministic hash;
- Event hashes form ordered hash-chain continuity;
- at configured intervals, a checkpoint commitment (for example a Merkle root) is generated;
- the checkpoint hash MAY be anchored to an external public blockchain;
- anchoring cadence is policy-configurable.

Anchoring clarifications:

- blockchain anchoring is not required for normal EventDB Core operation;
- anchoring does not replace local verification protocol;
- anchoring provides additional external consistency evidence for integrity checkpoints.

This optional layer is relevant for systems with strict integrity assurance requirements, including financial records, real-asset tokenization records, public sector registries, and other compliance-sensitive domains.

## 4. Layered Architecture (Textual Diagram)

EventDB Core layered model:

- Layer 1 - Event Store (Immutable Log):
  append-only Event persistence, canonical ordering, integrity baseline.
- Layer 2 - Projection Engine:
  deterministic transformation from Event stream to query-oriented state.
- Layer 3 - SQL Read Models:
  materialized relational views optimized for read/query workloads.
- Layer 4 - Application Layer:
  business APIs and application workflows consuming read models and issuing new Events.
- Optional Layer - Blockchain Anchor:
  external publication and verification of checkpoint commitments.

Separation of concerns:

- write integrity is governed by immutable Event recording and verification rules;
- read performance is governed by projection and relational optimization;
- optional external anchoring is governed by publication policy and verification interface.

## 5. Design Principles

- Append-only truth.
- Deterministic projection.
- Read/write separation (CQRS).
- Replayability.
- Tamper-evident integrity (optional).
- Infrastructure neutrality.

## 6. Positioning Statement

EventDB is not a blockchain system, nor merely a database with audit logs.

It is a verifiable event infrastructure capable of supporting enterprise-grade systems with optional cryptographic integrity guarantees.
