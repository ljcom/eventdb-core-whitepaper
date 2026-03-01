# integrity-boundary.md
EventDB Core - Integrity Boundary
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Scope

This section defines the boundary of integrity claims in EventDB Core.

## 2. Namespace Chain Integrity

Integrity guarantees apply per namespace Chain context.
Verification MUST be evaluated against the namespace-specific Chain sequence and related Seal artifacts.

## 3. Integrity Guarantee

Within a verified namespace Chain, EventDB Core guarantees deterministic tamper-evidence, sequence continuity, and signer accountability under defined rules.

## 4. Non-Guarantee

Namespace does not enforce business correctness.
Namespace does not validate legal validity, physical truth, or domain policy compliance.
