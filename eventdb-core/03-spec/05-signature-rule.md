# 05-signature-rule.md
EventDB Core - Signature Rule
Version: 0.1
Status: Draft


## 1. Scope

This section defines normative signature behavior for Event and Seal artifacts.

## 2. Signature Input

Signature input MUST be canonical covered input as defined in artifact-specific sections.
- Event signature input: canonical Event envelope excluding `signature`.
- Seal signature input: canonical Seal input excluding `signature`.

Implementations MUST NOT sign non-canonical representations.

## 3. Account Binding

Each signature MUST bind to one `account_id`.
Verifier MUST resolve `account_id` to active verification key material under governance policy.
Verification MUST fail if key mapping is missing, invalid, or revoked.

## 4. Algorithm Rule

Default signature algorithm SHOULD be Ed25519.
Alternative algorithms MAY be used only if explicitly version-governed and interoperably documented.
Algorithm choice MUST be explicit in profile documentation.

## 5. Validation

A signature is valid only if all conditions hold:
- canonical covered input exactly matches signed bytes;
- cryptographic verification succeeds;
- account status satisfies active policy.

Any signature validation failure MUST reject the artifact for integrity verification.
