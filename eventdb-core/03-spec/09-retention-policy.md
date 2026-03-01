# 09-retention-policy.md
EventDB Core - Retention Policy
Version: 0.1
Status: Draft


## 1. Policy Scope

Retention policy governs preservation and accessibility of integrity artifacts.

## 2. Mandatory Retained Artifacts

An implementation MUST retain, for policy-defined duration:
- Event envelopes required for verification scope;
- Seal artifacts and linkage;
- Snapshot metadata and verification basis;
- Anchor records when anchoring is enabled.

## 3. Tiered Archival

Artifacts MAY be moved between hot, warm, and cold domains.
Movement MUST preserve deterministic re-verification ability.

## 4. Deletion Constraint

Retention expiration MAY permit payload reduction under policy, but MUST NOT remove required integrity proof continuity for obligated verification periods.

## 5. Auditability

Retention and archival actions SHOULD be logged with accountable operator context.
