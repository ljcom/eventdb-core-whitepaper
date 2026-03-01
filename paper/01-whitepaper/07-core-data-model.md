# 07-core-data-model.md
EventDB Core - Core Data Model
Version: 0.1
Status: Draft


This section defines the conceptual data model of EventDB Core. The model is logical and verification-oriented. It specifies entity meaning, integrity role, and relationships, independent of storage schema or vendor implementation.

## 1. Account

### 1.1 Purpose

Account represents an identifiable signing authority within an institutional governance boundary.

### 1.2 Integrity Role

- Account enables signer accountability for Event and Seal issuance.
- Account identity MUST be stable enough for independent verification.
- Account status and authority scope SHOULD be governed by institutional policy.

### 1.3 Conceptual Notes

Account does not define business ownership or legal entitlement. It defines who produced signed integrity artifacts within the system boundary.

## 2. Chain

### 2.1 Purpose

Chain represents the ordered integrity sequence of Events maintained under a defined governance boundary.

### 2.2 Integrity Role

- Chain preserves sequence continuity through deterministic linkage.
- Chain verification MUST detect unauthorized reordering, omission, or insertion.
- Chain is append-only at the integrity layer.

### 2.3 Conceptual Notes

A Chain may be institution-local in a federation model. EventDB Core does not require a single global Chain.
One ledger boundary MAY contain multiple Chains.
Chains within the same ledger boundary MAY represent different operational partitions.
Partitioning MUST NOT alter canonical verification rules.
Integrity remains evaluated per Chain.

## 3. Event

### 3.1 Purpose

Event is the atomic immutable record unit in the model.

### 3.2 Integrity Role

- Each Event participates in Chain continuity.
- Each Event SHOULD be attributable to an accountable Account.
- Event content is integrity-preserved as recorded input; later correction MUST occur through new Events, not mutation.

### 3.3 Conceptual Notes

Event integrity proves tamper-evident preservation, not business truth. A valid Event sequence may still contain incorrect business assertions.

## 4. Seal

### 4.1 Purpose

Seal represents a cryptographic commitment over a bounded Event window in a Chain.

### 4.2 Integrity Role

- Seal provides checkpoint evidence for a specific sequence segment.
- Seal SHOULD reduce re-verification cost for long histories.
- Seal continuity SHOULD be verifiable across successive windows.

### 4.3 Conceptual Notes

Seal complements Event-level verification. It does not replace full Chain semantics.

## 5. Snapshot

### 5.1 Purpose

Snapshot represents a derived checkpoint of verified chain state used for operational efficiency.

### 5.2 Integrity Role

- Snapshot SHOULD accelerate read or verification workflows.
- Snapshot MUST be derivable from verified Chain and Seal state.
- Snapshot MUST NOT rewrite or invalidate historical Events.

### 5.3 Conceptual Notes

Snapshot is a performance artifact, not a substitute source of historical authority.

## 6. Conceptual Relationships

### 6.1 Account to Event

- One Account MAY issue many Events.
- Each signed Event SHOULD reference one accountable Account at issuance time.
- The relationship establishes authorship accountability, not business ownership semantics.

### 6.2 Chain to Event

- One Chain contains an ordered sequence of Events.
- Each Event belongs to one Chain context for verification.
- Event order within a Chain is integrity-significant and MUST be deterministic.

### 6.3 Account to Seal

- One Account MAY issue many Seals.
- Each Seal SHOULD be attributable to one accountable Account.
- This relationship supports auditable checkpoint authority.

### 6.4 Chain to Seal

- One Chain MAY have many Seals over time.
- Each Seal commits to a bounded Event window within one Chain.
- Seal sequence SHOULD provide continuity across windows.

### 6.5 Chain to Snapshot

- One Chain MAY have many Snapshots.
- Each Snapshot represents derived state at a specific Chain point.
- Snapshot references verified Chain history; it does not replace it.

### 6.6 Seal to Snapshot

- Snapshot generation SHOULD align with verified Seal or chain checkpoint boundaries.
- Snapshots MAY use Seal evidence to reduce replay cost during verification.

## 7. Model Boundaries

- The core data model defines integrity semantics and verification relationships.
- Storage mapping, indexing, partitioning, and physical schema are implementation concerns and are out of scope in this section.
- Conforming implementations MUST preserve these conceptual relationships even when physical models differ.
