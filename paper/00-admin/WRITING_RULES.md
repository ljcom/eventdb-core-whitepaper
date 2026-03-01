# WRITING_RULES.md
EventDB Core – Writing Standards
Version: 0.1

---

## 1. Tone

- Neutral
- Technical
- Deterministic
- Academic-ready

Avoid hype language.

---

## 2. Deterministic Language

Use:

- MUST
- MUST NOT
- SHOULD
- MAY

Avoid vague terms.

---

## 3. Separation of Layers

Never mix:

- Core integrity layer
- Domain implementation
- Policy extension

Each must be documented separately.

---

## 4. Hash Notation Standard

Use:

- H(x) for hash function
- prev_hash for previous event
- seal_hash for window seal

Do not change notation mid-document.

---

## 5. Diagrams

Every diagram must:

- Be referenced
- Use canonical terminology
- Match specification naming

---

## 6. Integrity Claims Rule

Never claim:

"Blockchain guarantees truth."

Use:

"Anchoring provides tamper-evident proof."

---

## 7. Specification Writing Rule

When describing a component:

Always define:

- Purpose
- Required fields
- Integrity implications
- Verification rule

---

## 8. Versioning

Each document must include:

- Version
- Status
- Change log reference

---

## 9. Core Identity Reminder

EventDB Core is:

- Hybrid
- Event-sourced
- Integrity-focused
- Governance-aware

Documentation must reflect this identity consistently.