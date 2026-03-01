# 00-glossary.md
EventDB Core - Glossary
Version: 0.1
Status: Draft


## Event

Event is the atomic immutable record unit in EventDB Core. An Event MUST be represented in a canonical envelope and MUST participate in deterministic verification. An Event MUST NOT be modified after acceptance into a Chain. Any correction MUST be represented by a subsequent Event.

## Chain

Chain is an ordered append-only sequence of Events bound by deterministic linkage. Chain order MUST be verifiable through sequence rules and previous-hash references. A Chain defines integrity continuity within a governance boundary. A Chain MUST support independent re-verification from canonical artifacts.

## Account

Account is an identifiable signing authority used for accountable issuance of integrity artifacts. An Account MUST be resolvable to verification key material under active governance policy. Account identity is used for attribution and verification, not for legal or business ownership claims. Account state changes such as rotation or revocation MUST be policy-governed.

## Federation

Federation is a deployment model in which multiple institutions operate separate Chains and exchange verifiable integrity artifacts. Federation MUST NOT require a mandatory global ledger. Each participant retains local governance authority over its own Chain and Account control. Cross-boundary trust MUST be evidence-based and deterministic.

## Integrity

Integrity is the property that recorded sequence evidence remains consistent, attributable, and tamper-evident under defined rules. In EventDB Core, integrity MUST include sequence immutability checks, linkage verification, and signature accountability. Integrity claims are bounded to the defined technical model. Integrity MUST NOT be interpreted as proof of business truth or legal validity.

## Tamper-evidence

Tamper-evidence is the ability to detect unauthorized modification, omission, insertion, or reordering of integrity-protected artifacts. Tamper-evidence MUST be machine-verifiable through deterministic hash and linkage checks. Tamper-evidence does not prevent all attacks; it makes unauthorized changes detectable. Detection reliability depends on correct canonicalization and verification execution.

## Seal

Seal is a cryptographic commitment over a bounded Event window in a Chain. A Seal MUST include deterministic window context and MUST link to prior Seal state through previous-seal reference. Seal verification MUST confirm commitment correctness and continuity. Seal is a checkpoint mechanism and MUST NOT replace Event-level integrity semantics.

## Snapshot

Snapshot is a derived checkpoint representation of verified Chain state at a specific point. Snapshot SHOULD reduce replay cost for read or verification workflows. Snapshot MUST be reproducible from verified Chain and Seal artifacts. Snapshot MUST NOT rewrite, replace, or invalidate historical Event evidence.

## Anchor

Anchor is optional external publication of a bounded integrity commitment derived from local verified artifacts. Anchor verification MUST compare locally recomputed commitment with externally published commitment. Anchor evidence MAY strengthen cross-boundary tamper-evident claims by providing external timestamp context. Anchor MUST NOT be interpreted as business truth or legal validity.

## Window

Window is a contiguous bounded range of Events within one Chain used for Seal commitment scope. Window boundaries MUST be deterministic and reproducible across verifiers. A Window MUST identify start and end sequence context unambiguously. Window definition MUST support non-overlapping Seal progression under active policy.

## Hash chaining

Hash chaining is the deterministic linkage method in which each artifact references a prior artifact hash. In EventDB Core, Event-level and Seal-level continuity MUST use previous-hash references validated in order. Any unauthorized change in covered input MUST propagate as linkage mismatch during re-verification. Hash chaining provides tamper-evidence through dependency propagation.

## Signature

Signature is the cryptographic proof that a specific Account approved canonical integrity input. Signature verification MUST be performed against canonical covered fields and the Account key mapping valid for policy context. A valid signature confirms accountable issuance of signed input, not factual correctness of payload content. Signature handling MUST support governance-controlled key lifecycle, including rotation and revocation.
