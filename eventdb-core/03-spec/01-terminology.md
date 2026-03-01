# 01-terminology.md
EventDB Core - Terminology
Version: 0.1
Status: Draft
Change Log Reference: 00-admin/PROJECT_MEMORY.md

## 1. Canonical Terms

Conforming documents and implementations MUST use the following terms with exact meaning:

- Event
- Chain
- Seal
- Snapshot
- Account
- Anchor

Definitions are normative in `03-spec/00-glossary.md`.

## 2. Prohibited Drift

Implementations MUST NOT introduce alternate core names for canonical terms.
Examples of non-conformant behavior include aliasing `Seal` as checkpoint artifact with incompatible semantics, or aliasing `Chain` as mutable log stream.

## 3. Normative Keywords

The keywords `MUST`, `MUST NOT`, `SHOULD`, and `MAY` are normative.
They indicate requirement strength and MUST be interpreted consistently across all spec sections.

## 4. Claim Boundaries

`Integrity` refers to sequence immutability evidence, tamper-evidence, and signer accountability.
`Integrity` MUST NOT be interpreted as business truth or legal validity.
