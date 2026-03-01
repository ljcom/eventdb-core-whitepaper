# 12-federation-model.md
EventDB Core - Federation Model
Version: 0.1
Status: Draft


This section defines the federated deployment model of EventDB Core. The model is governance-aware and integrity-focused: each institution can operate independently while still supporting cross-boundary verification.

## Ledger Boundary

A ledger boundary defines the scope within which Chain continuity, Seal checkpoints, and Account authority operate.
Each Chain MUST exist within exactly one ledger boundary.
Federation occurs between ledger boundaries.
A ledger boundary MAY correspond to an institution, tenant, or deployment unit.
A ledger boundary MUST NOT be interpreted as domain classification (for example, commodity type or asset class).

## 1. Single Institution Chain

In the base deployment form, one institution operates one or more Chains inside its own governance boundary.

- The institution controls Event issuance, Account authority, Seal policy, and verification operations.
- Integrity claims are local by default and bounded to the institution's accountable scope.
- External parties MAY verify published artifacts when made available, but operational authority remains local.

This model supports deterministic integrity without requiring shared infrastructure across organizations.

## 2. Multi-Institution Federation

In a federation, multiple institutions operate independent Chains and exchange integrity evidence for cross-boundary verification.

- Each institution maintains local governance, signing authority, and operational control.
- Federation interactions focus on verifiable artifacts, not shared mutable state.
- Cross-institution checks SHOULD rely on canonical verification rules and stable terminology.

Federation therefore extends verification reach while preserving institutional autonomy.

## Cross-Boundary Reference Principle

EventDB Core does not define shared state across institutions.
Cross-boundary interaction MUST be based on verifiable artifact exchange.
One institution MAY reference an externally issued Seal or Chain commitment as evidence.
Such reference MUST NOT merge Chains across boundaries.
Cross-boundary verification MUST NOT be interpreted as business acceptance or legal endorsement.

## 3. No Mandatory Global Ledger

EventDB Core does not require a mandatory global ledger.

- Institutions MUST be able to conform to core integrity rules without joining a shared global Chain.
- Federation participation MAY occur bilaterally or in grouped arrangements.
- Global synchronization is not a prerequisite for local integrity validity.

This design avoids forced centralization and supports incremental adoption across heterogeneous governance environments.

## 4. Trust Boundary Concept

A trust boundary defines where technical control, policy authority, and operational accountability are held.

Within one trust boundary:

- Account lifecycle control is local.
- Chain and Seal operations are policy-constrained by the institution.
- Verification and incident response follow local governance procedures.

Across trust boundaries:

- Assertions MUST be supported by verifiable evidence, not implicit trust.
- Evidence interpretation SHOULD be documented and repeatable.
- Disagreement handling requires governance processes outside core integrity mechanics.

Trust boundaries are explicit by design so that verifiers can distinguish local assurance from cross-boundary assurance.

## 5. Optional Consortium Extension

A consortium extension MAY be adopted when a defined group of institutions agrees on shared interoperability and policy constraints.

- Consortium rules MAY define common verification cadence, evidence exchange formats, and dispute workflow.
- Consortium participation MUST NOT remove an institution's local governance responsibility.
- Institutions outside the consortium MUST remain able to run compatible local Chains.

The consortium model is optional and additive. It is not part of minimum EventDB Core conformance.

## 6. Liability Boundary Clarification

Liability boundaries follow governance boundaries and MUST remain explicit.

- Each institution is accountable for the integrity artifacts it issues, signs, and publishes.
- Verification of another institution's artifacts does not transfer authorship or legal responsibility for underlying business content.
- Cross-boundary integrity consistency indicates evidence alignment, not acceptance of business truth or legal position.

Accordingly:

- Integrity responsibility is attributable to the issuing institution.
- Business truth assessment remains domain-governed and institution-specific.
- Legal validity is determined by applicable legal frameworks and is outside automatic integrity inference.

This separation protects technical rigor and clarifies responsibility in federated operation.
