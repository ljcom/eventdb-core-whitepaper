# 04-hashing-rule.md
EventDB Core - Canonical Hashing Rule
Version: 0.1
Status: Draft


## 1. Scope

This section defines normative hashing behavior for EventDB Core.
All conforming implementations MUST apply these rules exactly.

## 2. Canonical JSON Rule

Hash input MUST be generated from canonical JSON serialization.
Canonical JSON serialization MUST satisfy all of the following:

- Object keys MUST be sorted in lexicographic byte order.
- Array element order MUST be preserved exactly as provided.
- Numbers MUST be represented in a deterministic canonical form.
- Boolean values MUST be represented as `true` or `false`.
- Null values MUST be represented as `null`.
- Duplicate object keys MUST be rejected.

Two semantically equivalent inputs MUST serialize to one identical canonical byte sequence.
If canonicalization cannot produce a unique representation, hashing MUST fail.

## 3. Encoding Rule

Canonical JSON output MUST be encoded as UTF-8 before hashing.
Implementations MUST NOT hash UTF-16, UTF-32, locale-specific encodings, or platform-dependent byte representations.

Hash input bytes MUST be exactly the UTF-8 bytes of canonical JSON output.
Any byte-order mark (BOM) MUST NOT be included.

## 4. Hash Algorithm Default

Default hash algorithm MUST be SHA-256.

The digest output MUST be represented as lowercase hexadecimal when serialized.
Algorithm substitution MUST NOT occur implicitly.
If an implementation supports non-default algorithms, algorithm selection MUST be explicit and version-governed by policy.

## 5. Whitespace Variance Prohibition

Whitespace variance MUST NOT affect hash output.
The following MUST be treated as invalid non-canonical input states for hashing:

- pretty-printed formatting differences;
- trailing or leading whitespace outside canonical form;
- tab, newline, or spacing variations introduced by serializers.

Conforming implementations MUST hash canonical JSON output only.
Raw presentation formatting MUST NOT be hashed.

## 6. Determinism Requirements

Hashing behavior MUST be deterministic across environments.
For identical logical input:

- canonicalization output MUST be identical;
- UTF-8 byte sequence MUST be identical;
- hash digest MUST be identical.

Runtime environment, operating system, locale, and serializer implementation details MUST NOT change hash result.

## 7. Failure Behavior

Hash computation MUST fail if any of the following occurs:

- non-canonical JSON input cannot be normalized deterministically;
- required canonicalization rule is violated;
- input encoding is not valid UTF-8;
- selected hash algorithm is undefined for the active profile.

On failure, no hash value MUST be emitted.

## 8. Conformance Criteria

An implementation MUST be considered non-conformant if it:

- hashes non-canonical JSON;
- accepts whitespace-variant inputs as distinct hash inputs;
- uses non-UTF-8 input bytes;
- uses a default hash algorithm other than SHA-256;
- produces non-deterministic hash output for equivalent input.
