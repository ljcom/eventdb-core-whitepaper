# 14-profile-descriptor.md
EventDB Core - Profile Descriptor Specification
Version: 0.1
Status: Draft


## 1. Scope

This section defines a deterministic Profile Descriptor for implementation profiles.
The Profile Descriptor declares active options without changing core integrity semantics.

## 2. Purpose

A Profile Descriptor MUST provide explicit configuration needed by verifiers and operators to interpret profile-level choices consistently.
A Profile Descriptor MUST NOT redefine EventDB Core terminology, hash rules, signature rules, Chain ordering, Seal logic, or verification protocol.

## 3. Required Fields

A conforming Profile Descriptor MUST include:

- `profile_id`
- `profile_version`
- `spec_version`
- `hash_algorithm`
- `signature_algorithm`
- `genesis_prev_hash_value`
- `genesis_prev_seal_hash_value`
- `window_policy`
- `retention_policy_ref`
- `anchor_enabled`

## 4. Field Constraints

- `profile_id` MUST be a non-empty stable identifier string.
- `profile_version` MUST be explicit and monotonically managed by governance policy.
- `spec_version` MUST match a supported EventDB Core specification version.
- `hash_algorithm` MUST be explicitly declared and MUST be interoperable with verification participants.
- `signature_algorithm` MUST be explicitly declared and MUST map to verifiable Account key material.
- `anchor_enabled` MUST be boolean (`true` or `false`).

## 5. Validation Rules

A verifier MUST validate a Profile Descriptor before profile-dependent processing:

1. Validate all required fields are present.
2. Validate field format and constraint compliance.
3. Validate `spec_version` compatibility.
4. Validate algorithm declarations against active verifier capability.
5. Reject descriptor if any validation step fails.

If validation fails, profile-dependent verification MUST NOT proceed.

## 6. Conformance Boundary

A Profile Descriptor MAY restrict behavior by selecting tighter options.
A Profile Descriptor MUST NOT relax any core `MUST` requirement.
If profile content conflicts with core specification, the descriptor MUST be treated as non-conformant.

## 7. Determinism Requirement

Given identical Profile Descriptor content and identical verification input, compliant verifiers MUST produce equivalent outcomes.
Descriptor interpretation MUST NOT depend on environment-specific defaults, locale behavior, or undocumented inference.

## 8. Versioning and Change Control

Profile Descriptor updates MUST be versioned.
Any change that affects verification behavior SHOULD trigger policy-defined compatibility review.
Backward-incompatible updates MUST be explicitly flagged by governance policy.
