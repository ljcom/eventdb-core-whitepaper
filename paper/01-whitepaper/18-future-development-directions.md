# 18-future-development-directions.md
EventDB Core - Future Development Directions
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## X - Future Development Directions (Informative, Non-Normative)

The following areas are identified as potential extensions for future evolution of EventDB Core.
These items are not part of the current normative specification.

### 1. Cross-Boundary Evidence Package (CBEP)

Standardized packaging format for exporting verifiable event subsets across ledger boundaries, including:

- referenced chain headers;
- seal proofs;
- inclusion proofs;
- signature bundles.

Purpose: enable deterministic cross-institution verification without shared database access.

### 2. Reference Link Specification

Formalization of cross-boundary referencing format, including:

- `namespace_id`;
- `chain_id`;
- `event_id`;
- optional seal reference;
- optional anchor reference.

Purpose: standardize inter-ledger references while preserving boundary sovereignty.

### 3. Attestation Event Profile

Generic profile for third-party attestations, including:

- audit reports;
- laboratory results;
- certification evidence;
- notarial statements.

Purpose: structured representation of institutional attestations without altering integrity primitives.

### 4. Dispute and Correction Protocol

Standardized event patterns for:

- dispute declaration;
- correction proposal;
- correction acceptance;
- supersession references.

Purpose: explicit modeling of correction without mutating historical records.

### 5. Snapshot Format Standardization

Specification of minimal interoperable snapshot structure, including:

- snapshot header;
- basis seal reference;
- projection commitment hash;
- optional chunked commitment model.

Purpose: improve portability and bootstrap performance.

### 6. Retention and Pruning Policy Framework

Formal policy model for long-term data lifecycle management while preserving:

- seal continuity;
- verifiable integrity;
- anchor durability.

Purpose: enable sustainable large-scale deployments.

### 7. Selective Disclosure and Commitment Model

Commitment-based payload model allowing:

- partial disclosure;
- redacted payload storage;
- controlled reveal proofs.

Purpose: support privacy-sensitive domains without modifying integrity semantics.

### 8. Key Rotation and Delegation Model

Formal governance model for:

- signing key rotation;
- key revocation;
- delegated signing authority;
- optional multi-signature policy.

Purpose: institutional key lifecycle management.

These future directions aim to strengthen interoperability, governance, and operational resilience while preserving the minimal integrity-first philosophy of EventDB Core.
