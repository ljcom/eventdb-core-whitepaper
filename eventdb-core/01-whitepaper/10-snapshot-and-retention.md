# 10-snapshot-and-retention.md
EventDB Core - Snapshot and Retention
Version: 0.1
Status: Draft


This section defines the conceptual snapshot and retention model in EventDB Core. The goal is to improve operational scalability while preserving deterministic integrity claims. The focus is logical behavior, not storage engine design.

## 1. Snapshot Purpose

A Snapshot is a derived checkpoint representing verified Chain state at a defined point. It is introduced to reduce repeated full-history replay for routine operations.

The Snapshot purpose is bounded and specific:

- provide a reusable checkpoint for read and verification workflows;
- reduce operational overhead on long Chains;
- preserve deterministic relationship to underlying Event and Seal evidence.

A Snapshot is not an alternative source of truth. The authoritative integrity record remains the append-only Event sequence and its associated Seal continuity.

## 2. Performance Motivation

As Chain length increases, full replay for every validation or state reconstruction becomes progressively expensive. This cost appears in compute usage, latency, and operational complexity.

Snapshot use addresses this by enabling a verifier or service to start from a known verified checkpoint and process only subsequent Events. This approach SHOULD reduce average verification effort while keeping verification semantics intact.

Performance improvement is therefore a design objective, but it MUST remain secondary to integrity equivalence. If a Snapshot is unavailable or disputed, the system MUST still support deterministic verification from underlying Chain evidence.

## 3. Integrity Preservation

Snapshot mechanisms MUST preserve core integrity guarantees.

- Snapshot derivation MUST be traceable to verified Chain and Seal state.
- Snapshot content MUST be reproducible from canonical historical inputs under the same rules.
- Snapshot adoption MUST NOT weaken detection of Event omission, insertion, or unauthorized mutation.

A Snapshot may accelerate verification workflows, but it does not replace the need for verifiable linkage in Events and Seals. Integrity remains rooted in append-only continuity, with Snapshot acting as a computational checkpoint.

## 4. Archival Model: Hot, Warm, Cold

Retention strategy in EventDB Core is conceptualized as tiered archival domains:

- `hot` domain: recent, frequently accessed Event and verification artifacts used by active operational workflows.
- `warm` domain: less frequently accessed but still readily retrievable artifacts for periodic audit and reconciliation tasks.
- `cold` domain: long-term archival artifacts retained primarily for compliance, historical verification, or exceptional review.

Tier placement MAY change over time based on policy, operational demand, and retention obligations. However, tier migration MUST preserve integrity proof continuity. Movement across tiers is a location transition, not a semantic transition.

Retention policy SHOULD optimize cost and accessibility, but it MUST NOT break the ability to reconstruct and verify Chain continuity when required.

## 5. Why Snapshot Does Not Rewrite History

Snapshot is a derived representation of prior verified state, not a mutation mechanism.

- Creating a Snapshot does not alter historical Events.
- Replacing operational reads with Snapshot-based reads does not delete historical evidence.
- Archiving historical payloads does not remove integrity obligations for verifiability.

If a Snapshot differs from recomputed state from the same verified inputs, the Snapshot MUST be treated as invalid or stale. The Chain remains authoritative for dispute resolution.

This separation is essential: Snapshot improves performance, but history remains append-only and tamper-evident through Chain and Seal verification.

## 6. Scope Boundary

This section defines logical snapshot and retention behavior only. Physical storage layout, indexing, replication, and platform-specific archival mechanisms are implementation concerns and are intentionally excluded from this overview.
