# ledger-namespace.md
EventDB Core - Ledger Namespace
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Definition

A ledger namespace is a logical boundary identifier for Event chain grouping.
It partitions integrity artifacts into deterministic verification scopes.
A namespace is not a domain entity.

## 2. Rationale

Namespace allows boundary control for multi-tenant and governance-separated deployments while preserving one integrity model.
Namespace provides segmentation without changing hash chain design, signature semantics, or Seal logic.

## 3. Separation from Domain Account

Namespace MUST NOT represent a business account.
Namespace MUST NOT represent a user identity.
Namespace MUST NOT represent asset ownership.
Namespace MUST be interpreted only as ledger boundary context.

## 4. Deployment Models

### 4.1 Single Namespace (Default)

One institution operates one default namespace and one or more Chains inside that namespace context.
This model minimizes configuration complexity.

### 4.2 Multi-Namespace per Institution

One institution operates multiple namespaces for isolation and governance boundary separation.
Each namespace maintains independent deterministic Chain verification scope.

## 5. Deterministic Replay per Namespace

Replay and verification MUST execute against a single namespace scope at a time.
Given identical namespace-scoped input and rules, replay results MUST be identical across verifiers.
Cross-namespace aggregation MAY exist operationally but MUST NOT change per-namespace verification outcomes.
Verification is performed within a namespace boundary.

## 6. Seal per Namespace

Seal processing MUST be evaluated within namespace-scoped Chain context.
Seals are computed per (`namespace_id`, `chain_id`, `window_id`).
Seal windows and Seal continuity MUST NOT cross namespace boundaries.
Namespace context MUST NOT alter Seal computation rules.
