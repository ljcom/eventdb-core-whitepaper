# 03-problem-statement.md
EventDB Core - Problem Statement
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

Enterprise information systems are generally designed around mutable data stores. This design supports correction, operational agility, and lifecycle management, but it does not provide deterministic guarantees about historical integrity. Records can be updated or deleted, and historical state is often reconstructed from auxiliary artifacts rather than preserved as a cryptographically verifiable sequence. For institutions that require reliable historical evidence, this creates a persistent structural risk: operational systems can process transactions correctly while still failing to prove that prior records were not altered after the fact.

This risk becomes material during audit, dispute resolution, cross-organization reconciliation, and regulatory review. In each context, institutions need more than current-state correctness. They need verifiable continuity of historical records and clear accountability for changes. Traditional controls such as role permissions, approval workflows, and database backups SHOULD remain in place, but those controls are governance mechanisms, not integrity proofs. Where privileged actors can modify both data and metadata, trust remains centralized and historical claims remain difficult to verify independently.

## Limitations of Mutable Databases

Mutable databases are optimized for the latest valid state, not immutable sequence preservation. Four limitations are recurrent.

First, historical reconstruction is indirect. Current tables usually keep final values, while prior values depend on logs or application history structures. This increases complexity and introduces interpretation risk.

Second, continuity is weakly bound. Many systems do not cryptographically link successive records. Without deterministic linkage, reviewers cannot reliably detect selective deletion, silent reordering, or retrospective insertion.

Third, privileged mutation is inherent. Administrators and service accounts need broad access for maintenance and incident response. These capabilities are operationally necessary, but they also create a single-domain trust model that cannot independently prove tamper evidence.

Fourth, multi-system consistency is procedural. Enterprises commonly operate multiple applications with overlapping records. If each application mutates history independently, reconciliation requires manual correlation and judgment, and definitive sequence authority is hard to establish.

These limitations do not imply that mutable databases are unusable. They indicate that mutable databases alone are insufficient where deterministic historical integrity is a primary requirement.

## Weak Audit Trails

Audit trails are widely used to compensate for mutability, yet they are frequently incomplete in scope and uneven in quality.

In many deployments, only selected entities are audited, retention windows differ by subsystem, and change entries are stored without canonical representation. Some logs capture actor and timestamp but not full before-and-after context. Others record deltas that depend on application-specific interpretation.

Even comprehensive audit tables may remain within the same administrative boundary as operational data. If the same privileged domain can alter both records and logs, then audit continuity is not independently enforceable. Storage separation MAY reduce exposure, but without deterministic verification rules, omission and tampering risks persist.

A further issue is ambiguity. Batch correction jobs, migration scripts, and replay mechanisms can produce patterns that resemble unauthorized manipulation. Investigators must then rely on process narratives to interpret logs. This elevates review cost and reduces confidence under contested conditions.

Audit trails therefore SHOULD be treated as observability and accountability support, not as a complete integrity layer. They are necessary but not sufficient for tamper-evident historical assurance.

## Why Full Blockchain Is Often Impractical

Public blockchain infrastructure provides strong tamper-evident properties, but full adoption is often impractical for institutional core systems.

Operationally, enterprise Event volumes and latency constraints may not align with public network confirmation behavior. Core workflows frequently require predictable processing and bounded delays. Public consensus introduces variability that institutions cannot always absorb.

Economically, external fee markets create variable write costs. Institutions generally require budget predictability and controllable operating expenditure for mission-critical systems.

Governance and operations are also misaligned. Wallet-centric key handling, transaction lifecycle tooling, and chain-specific failure modes are not native to many enterprise control environments. Integrating these patterns can be done, but it introduces additional complexity, training burden, and risk.

Data boundary requirements further constrain full migration. Institutions often need strict control over data residency, confidentiality, and access scope. Public publication of business records is typically unacceptable, while private network deployments may reintroduce concentrated trust without automatically resolving integrity semantics.

Therefore, the practical requirement is not total replacement of enterprise databases with blockchain systems. The requirement is an integrity layer that can operate with existing systems while providing deterministic tamper evidence.

## Need for Institutional Governance

Integrity mechanisms in enterprise settings MUST be governance-aware. Technical proofs have limited operational value unless roles, authority, and responsibility are explicit.

Institutions need defined control over Event issuance, Account management, Seal generation, verification duties, and exception handling. Separation of duties SHOULD be explicit to reduce concentration risk and to support independent review.

In federated settings, each institution may maintain its own Chain and policies. Interoperability therefore depends on verifiable evidence across governance boundaries, not on a single mandatory global ledger. Verifiers must be able to determine which institution produced which integrity artifact and under what rules.

Without governance clarity, integrity evidence can exist but still fail to support decisions. Governance is thus a core requirement of the problem, not an optional implementation detail.

## Data Integrity, Business Truth, and Legal Validity

A key conceptual gap in current practice is conflation of data integrity with business truth.

Data integrity concerns whether records are preserved in a tamper-evident, attributable sequence. If a Chain verifies and Seals validate, the system can support bounded claims about sequence continuity and accountability.

Business truth concerns whether recorded content corresponds to real-world events, contractual intent, or factual correctness. Integrity mechanisms do not establish this by themselves. A deterministically preserved sequence can still contain incorrect or fraudulent input.

Legal validity is a separate dimension and MUST remain distinct from both. Legal validity depends on jurisdiction, regulation, contractual context, and procedural compliance outside the integrity layer. Technical evidence MAY support legal analysis, but it does not automatically create legal force.

For this reason, system documentation and governance language MUST keep boundaries explicit:

- Integrity evidence addresses tamper evidence, sequence continuity, and signer accountability.
- Business truth requires domain verification and institutional adjudication.
- Legal validity requires legal interpretation under applicable frameworks.

The central problem addressed by EventDB Core is the absence of a deterministic integrity layer that fits enterprise operational constraints, supports institutional governance, and preserves strict separation between integrity claims, business truth, and legal validity.

## Design Objectives

- The core model MUST preserve append-only Event history with deterministic Chain linkage.
- Verification rules MUST detect tampering, omission, and unauthorized reordering.
- Sealing MUST provide periodic integrity commitments for bounded Event windows.
- Anchoring MAY be used to extend tamper-evident proof beyond local infrastructure and MUST remain optional.
- The architecture MUST support explicit institutional governance boundaries and accountable Account control.
- The specification MUST separate integrity guarantees from business truth assertions.
- The specification MUST separate integrity evidence from legal validity claims.
- The model SHOULD integrate with existing enterprise database environments without requiring full blockchain migration.
- Canonical terminology and deterministic language MUST remain stable across documentation and specification artifacts.
