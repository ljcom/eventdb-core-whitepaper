# 11-anchoring-interface.md
EventDB Core - Anchoring Interface
Version: 0.1
Status: Draft


This section defines the conceptual anchoring interface in EventDB Core. Anchoring is treated as an optional integrity extension that publishes bounded proof artifacts to an external system. It is not a replacement for core Chain and Seal verification.

## 1. What Anchoring Means

Anchoring means publishing a compact integrity commitment derived from verified EventDB Core artifacts to an external proof surface.

In practice, the committed object is typically related to Seal-level evidence rather than full Event payload data. The purpose is to establish externally observable tamper-evident reference points for later verification.

Anchoring does not change local integrity semantics. Local Chain and Seal verification remain the primary integrity mechanism.

## 2. Why Anchoring Is Optional

Anchoring is optional by design.

- Core integrity guarantees MUST remain valid without any external Anchor.
- Institutions with strict boundary or policy constraints MAY operate without anchoring.
- Anchoring SHOULD be enabled only when cross-boundary proof visibility is required.

Making anchoring optional preserves deployment flexibility, governance autonomy, and operational compatibility with enterprise constraints.

## 3. Anchor Payload

Anchor payload is the minimal deterministic data needed to bind external publication to internal integrity state.

Anchor payload SHOULD include:

- identifier of the source Chain context;
- reference to the committed Seal or checkpoint;
- canonical commitment hash (for example, a Seal-derived digest);
- anchor publication metadata required for later lookup and verification.

Anchor payload MUST avoid embedding business-domain payload content unless explicitly required by policy. The interface is for integrity commitments, not business data distribution.

## 4. Verification Process

Anchor verification is a comparison procedure between internal evidence and external publication evidence.

A conforming verification flow SHOULD:

- recompute the expected commitment from local canonical Chain and Seal artifacts;
- retrieve published Anchor evidence from the external system;
- compare expected commitment and published commitment deterministically;
- record verification result with accountable review context.

Verification success indicates consistency between local integrity state and published Anchor evidence at the checked point. Verification failure indicates mismatch, missing publication, or unresolved state divergence and MUST trigger policy-defined investigation.

## 5. External Timestamp Function

Anchoring provides an external timestamp function by associating a published commitment with the external system's recorded publication time.

This function MAY support claims that a specific integrity commitment existed no later than a certain externally observable point. It strengthens temporal evidence across governance boundaries.

External timestamp evidence remains bounded:

- it supports timing evidence for commitment publication;
- it does not prove business event correctness;
- it does not establish legal validity by itself.

## 6. Separation from Business Logic

The anchoring interface MUST remain separate from business logic.

- Anchoring decisions SHOULD be driven by integrity policy, not business workflow side effects.
- Anchor success or failure MUST NOT silently alter business-domain state semantics.
- Business rule evaluation, legal adjudication, and domain truth assessment remain outside anchoring scope.

This separation prevents conceptual drift and preserves the role of anchoring as integrity evidence only.

## 7. Scope Boundary

This section defines logical interface behavior only. Network selection, adapter implementation, submission protocols, and operational retry strategies are implementation concerns and are defined outside this whitepaper section.
