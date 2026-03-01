# 14-performance-and-ops.md
EventDB Core - Performance and Operations
Version: 0.1
Status: Draft


This section outlines operational considerations for running EventDB Core at enterprise scale. The focus is on integrity-preserving performance strategy and operational control boundaries. Recommendations are implementation-agnostic and avoid vendor-specific assumptions.

## 1. Operational Principles

Operational tuning in EventDB Core MUST preserve deterministic verification semantics. Performance improvements are valid only when they keep integrity outcomes equivalent under canonical rules.

Two principles apply throughout:

- optimize execution paths, not integrity definitions;
- separate high-frequency local processing from lower-frequency integrity checkpoint workflows.

## 2. Append-Only Indexing Considerations

EventDB Core uses append-only Event history at the integrity layer. Operational indexing strategy SHOULD reflect this write pattern.

Key considerations:

- Write paths SHOULD favor sequential append behavior to reduce contention.
- Read paths SHOULD prioritize deterministic retrieval by Chain and sequence boundaries.
- Verification workloads SHOULD be able to access contiguous Event segments efficiently.
- Historical search capabilities MAY use additional indexes, but those indexes MUST NOT alter canonical ordering semantics.

Index maintenance cost grows with history depth. Operational policy SHOULD balance query latency targets against write amplification and maintenance overhead.

## 3. Seal Frequency Tradeoff

Seal cadence determines checkpoint density and verification granularity.

Higher Seal frequency:

- SHOULD reduce average verification scope per check;
- SHOULD improve early detection of continuity anomalies;
- MAY increase signing workload and operational overhead.

Lower Seal frequency:

- MAY reduce operational overhead of Seal generation;
- MAY increase replay scope during verification and incident analysis;
- MAY delay visibility of integrity discontinuities between checkpoints.

Seal policy SHOULD be set by governance and risk tolerance. The chosen cadence MUST be explicit, measurable, and enforceable.

## 4. Snapshot Frequency

Snapshot cadence affects replay cost, read latency, and operational consistency.

Higher Snapshot frequency:

- SHOULD reduce average reconstruction latency;
- MAY increase background compute and checkpoint management overhead.

Lower Snapshot frequency:

- MAY reduce checkpoint overhead;
- MAY increase time-to-reconstruct for large Chain segments.

Snapshot policy MUST preserve integrity equivalence:

- Snapshots MUST be derivable from verified Chain and Seal state.
- Snapshot usage MUST allow deterministic fallback to underlying evidence.
- Snapshot lifecycle policy SHOULD define freshness thresholds and invalidation triggers.

## 5. Key Management

Key management is an operational prerequisite for trustworthy signature-based integrity.

Required operational controls:

- Account key ownership and authorization scope MUST be explicit.
- Key rotation and revocation procedures MUST be defined and testable.
- Signing operations SHOULD be auditable with clear responsibility trails.
- Separation of duties SHOULD reduce concentration risk in signing authority.

Compromised key scenarios MUST be operationally rehearsed. Incident handling SHOULD include compromise window identification, artifact re-verification, and governance escalation.

## 6. Backup and Recovery

Backup and recovery policy MUST preserve both data availability and integrity verifiability.

Backup considerations:

- Event, Seal, and related verification artifacts MUST be covered by retention policy.
- Backup cadence SHOULD align with acceptable recovery-point and recovery-time objectives.
- Backup integrity SHOULD be periodically tested through deterministic re-verification exercises.

Recovery considerations:

- Recovery workflows MUST reconstruct a state that can be re-verified under canonical rules.
- Post-recovery checks SHOULD include Chain continuity, Seal continuity, and Snapshot consistency validation.
- Recovery success MUST be defined not only by service availability but also by integrity equivalence.

## 7. Operational Boundary and Non-Claims

Operational controls in this section improve reliability and integrity assurance but do not redefine core claims. EventDB Core operations:

- support deterministic tamper-evident verification;
- improve scalability through checkpoint and retention policy;
- require governance discipline for sustained assurance.

Operational maturity does not convert integrity proof into business truth or legal validity. Those remain separate governance and legal dimensions.
