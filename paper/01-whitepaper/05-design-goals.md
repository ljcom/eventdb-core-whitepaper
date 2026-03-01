# 05-design-goals.md
EventDB Core - Design Goals
Version: 0.1
Status: Draft


- The core integrity model MUST be deterministic. Equivalent Event input under the same canonical rules MUST produce equivalent verification outcomes across independent verifiers.
- Hashing, signature, Chain ordering, and Seal verification rules MUST be explicitly defined and MUST NOT depend on implicit runtime behavior.
- Event history MUST be append-only. Existing Event records MUST NOT be rewritten or deleted as part of normal operation.
- Sequence continuity MUST be verifiable through deterministic linkage between Events and between Seals.
- Snapshot mechanisms SHOULD improve verification and read performance, but snapshots MUST NOT rewrite or invalidate prior Chain history.
- Institutional signing MUST be first-class. Each signed Event or Seal MUST be attributable to an accountable Account within an explicit governance boundary.
- Signature validation rules MUST support independent verification by external auditors and peer institutions without requiring privileged database access.
- The federation model MUST be federation-first. Each institution MUST be able to operate its own Chain under local governance without mandatory dependence on a single shared ledger.
- Cross-institution verification SHOULD rely on interoperable integrity artifacts and deterministic verification rules rather than centralized trust assumptions.
- Anchoring MUST be optional. Core integrity guarantees MUST remain valid without Anchor publication.
- When anchoring is used, Anchor evidence MAY strengthen tamper-evident proof across governance boundaries, but it MUST NOT be interpreted as business truth or legal validity.
- The core design SHOULD remain compatible with enterprise SQL environments, including PostgreSQL and MSSQL operational patterns.
- Integrity controls SHOULD minimize disruption to existing transactional systems and SHOULD avoid requiring full blockchain migration.
- Performance characteristics MUST support practical enterprise workloads by separating high-frequency local Event processing from optional external Anchor workflows.
- The specification MUST preserve stable canonical terminology: Event, Chain, Seal, Snapshot, Account, and Anchor.
