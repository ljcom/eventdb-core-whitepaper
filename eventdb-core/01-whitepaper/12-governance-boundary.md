# 12-governance-boundary.md
EventDB Core - Governance Boundary
Version: 0.1
Status: Draft


This section defines governance boundaries for EventDB Core with emphasis on accountability, auditability, and liability clarity. The objective is to ensure that technical integrity controls are interpreted within explicit institutional responsibility structures.

## 1. Institutional Responsibility Boundary

Each institution operating a Chain is the primary accountable party for controls within its governance scope. This responsibility includes policy definition, control enforcement, verification oversight, and incident response for locally issued integrity artifacts. Institutions MUST define decision authority for Event acceptance, Seal issuance policy, and exception handling. Institutions MUST maintain evidence that governance controls were applied consistently.

## 2. Operator Responsibility

Operators are responsible for running verification workflows, maintaining service continuity, and escalating integrity anomalies under approved procedures. Operator authority MUST be policy-bounded and auditable. Operational actions affecting Event, Seal, Snapshot, or Anchor processing SHOULD be logged with accountable identity and timestamp context. Operators MUST NOT redefine integrity outcomes outside normative verification rules.

## 3. Key Ownership Responsibility

Key ownership responsibility remains with the institution that authorizes corresponding Accounts. Institutions MUST define key lifecycle controls, including issuance, storage protection, rotation, revocation, and compromise response. Signing authority delegation MUST be explicit and reviewable. A valid signature proves accountable key use under the model, but governance MUST determine whether that use was authorized in organizational terms.

## 4. Data Retention Responsibility

Retention responsibility includes preserving verifiable integrity evidence for required review periods. Institutions MUST retain sufficient Event, Seal, and related verification artifacts to support deterministic re-verification for policy-defined horizons. Tiered archival MAY be used, but migration across hot, warm, and cold domains MUST preserve proof continuity. Retention reduction decisions MUST NOT invalidate required auditability or regulatory evidence obligations.

## 5. Anchor Responsibility

When anchoring is enabled, the issuing institution is responsible for correctness of published commitment mapping to local verified state. Anchor publication policy MUST define cadence, failure handling, reconciliation, and evidence retention. Anchor verification duties MUST be assigned explicitly for both routine and incident conditions. Optional anchoring does not transfer core integrity responsibility away from local Chain governance.

## 6. What Integrity Proof Guarantees

Integrity proof in EventDB Core guarantees bounded technical properties when verification passes:

- deterministic sequence continuity under canonical rules;
- tamper-evidence for covered artifacts;
- attributable issuance through verifiable Account signatures;
- checkpoint continuity where Seals are applicable;
- consistency checks between local commitments and external Anchor evidence when used.

These guarantees are technical and evidence-oriented.

## 7. What Integrity Proof Does Not Guarantee

Integrity proof does not guarantee:

- factual correctness of business content;
- legal enforceability of records;
- regulatory compliance by default;
- authorization legitimacy beyond key possession evidence;
- physical-world authenticity of referenced objects or states.

These determinations require additional governance, legal, and domain controls outside the core integrity layer.

## 8. Liability Separation in Federated Deployment

In federated deployment, liability follows issuing governance boundaries. Each institution is liable for integrity artifacts it generates, signs, stores, and publishes. Verification by a peer institution establishes evidence consistency, not transfer of authorship or legal responsibility for underlying content.

Accordingly:

- local issuance liability remains with the issuing institution;
- cross-boundary verification liability is limited to correctness of the verifier's executed checks;
- shared federation participation does not create automatic joint liability unless established by external legal agreement.

This separation supports transparent accountability while preserving independent governance in multi-institution operation.
