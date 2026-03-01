# 09-sealing-and-windows.md
EventDB Core - Sealing and Windows
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

This section defines the conceptual model for Event windows and Seals in EventDB Core. The focus is integrity checkpointing over Chain segments. External anchoring behavior is intentionally out of scope here.

## 1. Purpose of Window

A window is a bounded segment of ordered Events within one Chain. Windowing partitions long Event history into verifiable units that can be processed and reviewed with predictable scope.

Windowing serves four integrity-oriented purposes:

- It defines explicit boundaries for periodic integrity commitments.
- It reduces verification cost compared with full-history replay for routine checks.
- It supports operational checkpoint cadence under institutional governance.
- It improves detectability of omission or discontinuity at segment boundaries.

A window MUST be defined deterministically. All compliant verifiers MUST identify the same Event set for a given window definition.

## 2. Seal Creation Rule

A Seal is a cryptographic commitment over a specific window in a Chain.

Seal creation MUST follow deterministic rules:

- The target window boundary MUST be explicit and reproducible.
- The committed input set MUST include all Events in that window according to Chain order.
- Canonical hashing inputs for Seal computation MUST be stable across verifiers.
- Seal issuance SHOULD be attributable to an accountable Account.

Given identical window contents and canonical rules, independent verifiers MUST compute equivalent Seal outcomes.

## 3. `prev_seal_hash` Linkage

`prev_seal_hash` links each Seal to the preceding Seal in the same Chain context.

- For every Seal after the first, `prev_seal_hash` MUST reference the prior Seal hash.
- Missing or altered Seal records MUST be detectable by linkage break.
- Reordered Seal sequence MUST fail deterministic continuity checks.

This creates a second continuity layer above Event-level `prev_hash` linkage. Event linkage protects intra-window and cross-window sequence integrity at the Event level, while `prev_seal_hash` protects integrity of checkpoint progression.

## 4. Why Sealing Strengthens Integrity

Sealing strengthens integrity by adding periodic, signed commitments over bounded Chain history.

Without Seals, verification can still be performed from Event linkage, but full-history checks may be operationally expensive as Chain length grows. With Seals, institutions can verify checkpoint continuity first, then selectively expand to Event-level verification when required by policy or dispute context.

Seals also improve governance visibility. Because each Seal corresponds to a defined window, review processes can evaluate integrity status at predictable intervals. This supports auditability without changing append-only Event semantics.

Sealing therefore strengthens integrity by improving scalability, detectability, and checkpoint accountability while preserving deterministic verification boundaries.

## 5. Why Sealing Does Not Validate Business Truth

A valid Seal proves bounded integrity properties only:

- the committed window corresponds to deterministic input under canonical rules;
- the Seal chain continuity is intact;
- accountable issuance can be evaluated.

A valid Seal does NOT prove that Event payloads are factually correct, legally enforceable, or complete representations of external reality. Incorrect or misleading business content can still be sealed if it was recorded and processed consistently.

For this reason, Seal verification MUST be interpreted as integrity evidence, not as confirmation of business truth. Domain validation, legal interpretation, and factual adjudication remain outside the Seal model.

Deterministic verification is scoped per Chain within a ledger boundary.
Verification across ledger boundaries requires verifiable artifact exchange rather than shared ordering assumptions.

## 6. Scope Boundary

This section defines only windowing and sealing semantics at the integrity layer. Storage-specific design, transport details, and external publication mechanisms are implementation or interface concerns addressed in other sections.
