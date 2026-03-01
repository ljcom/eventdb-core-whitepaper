# compute-event-hash.md
EventDB Core MVP Script Notes - Compute Event Hash
Version: 0.1
Status: Draft

## Objective

Recompute Event hash from canonical Event envelope input.

## Steps

1. Validate required Event fields.
2. Build covered input excluding `signature`.
3. Canonicalize to deterministic JSON bytes.
4. Encode as UTF-8.
5. Compute SHA-256 digest.
6. Emit lowercase hexadecimal hash.

## Failure Rule

Any canonicalization or field validation failure MUST produce no hash output.
