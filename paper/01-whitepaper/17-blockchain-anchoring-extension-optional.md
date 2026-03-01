# 17-blockchain-anchoring-extension-optional.md
EventDB Core - Section X - Blockchain Anchoring Extension (Optional)
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## Section X - Blockchain Anchoring Extension (Optional)

This section defines an optional extension for external anchor publication. The extension preserves EventDB Core architectural neutrality, keeps ledger boundary sovereignty, and does not modify internal integrity primitives.

### 1. Purpose of Anchoring

Anchoring provides external timestamp evidence for already-verified internal commitments. Anchoring MAY strengthen tamper-evidence credibility in cross-boundary review contexts by publishing commitment hash material only.

Anchoring MUST NOT publish raw Event payload data. Anchoring MUST NOT replace internal Seal integrity.

EventDB integrity verification MUST remain fully functional without anchoring.

### 2. Anchor Commitment Model

Anchoring input MUST be one of the following internal commitment artifacts:

- `seal_hash`; or
- `window_commitment_hash`; or
- `snapshot_hash`.

Raw Event data MUST NOT be used as anchor input.

Anchor commitment is defined abstractly as:

- `Anchor_Commitment = H(seal_hash || anchor_metadata)`.

`anchor_metadata` MAY include:

- `ledger_boundary_id`;
- `anchor_sequence`;
- `anchor_timestamp`.

The commitment model MUST remain blockchain-agnostic.

### 3. External Publication Model

Anchor publication MAY occur through one of the following external publication surfaces:

- public blockchain;
- consortium chain;
- public notarization service;
- time-stamping authority.

EventDB Core does not prescribe chain or provider selection.

### 4. Anchor Verification Semantics

Anchor verification SHOULD follow this sequence:

1. Verify internal Seal integrity.
2. Recompute anchor commitment from internal artifact and declared metadata.
3. Compare recomputed commitment with published anchor record.
4. Verify inclusion proof, if the selected publication surface provides one.

Failure of anchor verification does not invalidate internal ledger continuity. It only weakens external timestamp evidence.

### 5. Sovereignty and Boundary Protection

Anchoring does not merge ledger boundaries. Anchoring does not imply shared state. Anchoring does not create consensus dependency. Anchoring does not introduce cross-ledger synchronization.

Each ledger boundary remains sovereign for internal Chain continuity, Seal policy, and verification authority.

### 6. Policy and Frequency

Anchoring is institution-governed and policy-driven.

Anchoring frequency MAY be configured as:

- per Seal window;
- per day;
- per milestone.

Anchoring MAY be disabled per deployment without affecting internal integrity verification conformance.

### 7. Non-Goals

Anchoring does NOT provide:

- legal enforceability;
- physical authenticity proof;
- regulatory approval;
- automatic dispute resolution;
- distributed transaction atomicity;
- marketplace functionality.

### 8. Diagram (Textual)

```text
[EventDB Ledger Boundary]
          ↓ Seal
          ↓ Anchor Commitment
[External Publication Layer]
          ↓ Optional Verification

Integrity = Internal
Anchoring = External evidence reinforcement
```

### 9. Anchoring Assurance Levels

EventDB Core defines three optional anchoring assurance levels.
All levels are fully compatible with ledger boundary sovereignty.

#### Level 0 - No External Anchoring

Description:

- No external publication.
- Integrity is verified through Event continuity, Seal chain, and Snapshot verification.

Guarantees:

- Tamper-evident internally.
- Deterministic replay is possible.
- No external dependency.

Use Case:

- Internal enterprise deployment.
- Low-risk systems.
- Early pilots.

#### Level 1 - Seal-Level Anchoring

Anchor Object:

- `seal_hash`.

Description:

- Each Seal window produces a commitment hash.
- Commitment is published to an external anchor network.
- Snapshot anchoring is optional.

Guarantees:

- External timestamp evidence.
- Window-level tamper evidence.
- Lightweight operational overhead.

Does NOT Provide:

- Cross-ledger atomicity.
- Shared consensus.
- Legal enforceability.

Recommended For:

- Regulator-facing traceability.
- Agricultural export.
- Nusantara baseline deployment.

#### Level 2 - Seal + Snapshot Anchoring

Anchor Object:

- `seal_hash`.
- `snapshot_hash`.

Description:

- Seal-level anchoring as in Level 1.
- Snapshot state commitments are additionally anchored.

Guarantees:

- Stronger evidentiary reconstruction.
- Faster audit replay.
- State-level external timestamping.

Recommended For:

- Institutional audit infrastructure.
- Compliance-heavy deployments.
- Cross-organization regulatory systems.

#### Level 3 - Multi-Anchor Redundancy

Anchor Object:

- `seal_hash`.
- `snapshot_hash`.
- optional milestone commitments.

Publication Model:

- Multiple external anchor networks.
- Heterogeneous publication (public chain + timestamp authority + consortium).

Guarantees:

- Anti-single-point compromise.
- Maximum external timestamp resilience.
- High-value asset suitability.

Important Constraint:

Level 3 does NOT:

- Merge ledger boundaries.
- Introduce consensus dependency.
- Create cross-ledger state synchronization.
- Replace internal integrity verification.

Recommended For:

- Real World Asset systems.
- High-value commodity chains.
- National infrastructure use cases.

### 10. Safety Statement

Increasing anchoring assurance level strengthens external evidentiary durability but does not alter internal ledger semantics or integrity verification logic.
