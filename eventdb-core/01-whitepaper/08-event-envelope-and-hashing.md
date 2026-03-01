# 08-event-envelope-and-hashing.md
EventDB Core - Event Envelope and Hashing
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

This section explains the conceptual structure of the Event envelope and the hashing logic used for deterministic integrity verification. It defines what MUST be stable for verification and why canonical representation is required.

## 1. Conceptual Purpose

The Event envelope is the integrity boundary for one Event in a Chain. It packages identity, ordering context, signer context, and recorded content into a deterministic form that can be hashed and verified independently.

At this layer, the objective is not storage efficiency. The objective is reproducible integrity evidence: the same Event input MUST yield the same hash result across compliant verifiers.

## 2. Event Envelope Field List

A canonical Event envelope MUST include the following logical fields:

- `chain_id`: identifies the Chain context to which the Event belongs.
- `event_id`: identifies the Event within the issuing scope.
- `sequence`: defines deterministic Event order in the Chain.
- `prev_hash`: links the Event to the prior Chain state.
- `account_id`: identifies the accountable Account that issues or signs the Event.
- `event_type`: identifies the declared Event classification.
- `event_time`: records Event issuance time in canonical format.
- `payload`: contains the recorded Event content under canonical serialization rules.
- `signature`: contains the integrity signature over the defined signing input.

Implementations MAY carry additional operational metadata, but non-canonical fields MUST NOT alter canonical hash computation.

## 3. Canonical JSON Rule

Canonical serialization is required before hashing. Equivalent Event meaning MUST map to one canonical byte representation.

Canonical JSON rules SHOULD enforce:

- stable key ordering;
- explicit UTF-8 encoding;
- deterministic number and boolean representation;
- no non-deterministic whitespace;
- deterministic null and empty structure handling.

If two systems serialize semantically identical Event data differently, hash outputs diverge and Chain verification fails. Therefore, canonical JSON is not an optimization detail; it is a core integrity requirement.

## 4. Hash Computation Principle

Hashing in EventDB Core follows a deterministic input-to-digest principle.

- Let canonical envelope bytes be represented as `E`.
- Event hash is defined as `H(E)`.
- The hash algorithm and input scope MUST be fixed by specification.

The model depends on reproducibility, not secrecy. Verifiers MUST be able to recompute Event hash from canonical Event input and reach identical results.

## 5. `prev_hash` Chaining

`prev_hash` establishes continuity across Events in a Chain.

- For each Event after the first, `prev_hash` MUST reference the hash of the previous Event in deterministic order.
- Any unauthorized change to prior Event content changes prior hash output and propagates mismatch forward.
- Reordering or omission attempts break linkage consistency and MUST be detectable during verification.

This mechanism is the minimal structural basis for append-only tamper evidence.

## 6. Why Determinism Is Required

Determinism is required because integrity verification is comparative. Different verifiers, running in different environments, MUST produce the same result from the same input.

Without determinism:

- hash equality becomes environment-dependent;
- chain validity becomes ambiguous;
- audit outcomes become non-reproducible;
- integrity claims lose evidentiary value.

With determinism:

- verification is portable across institutions;
- tamper detection is machine-checkable;
- governance review can rely on bounded, repeatable integrity claims.

Determinism therefore MUST be treated as a non-negotiable property of the Event envelope and hashing model.

## 7. Formal Specification References

This whitepaper section is conceptual. Normative definitions, required fields, and verification rules are specified in:

- `03-spec/03-event-envelope.md` for envelope field semantics and required scope;
- `03-spec/04-hashing-rule.md` for canonical hashing input and digest rules;
- `03-spec/06-chain-and-ordering.md` for Chain ordering and `prev_hash` verification constraints;
- `05-mvp/scripts/canonical-json.md` for canonical JSON implementation guidance.

Where this overview and formal specification differ, the formal specification MUST take precedence.
