# build-seal.md
EventDB Core MVP Script Notes - Build Seal
Version: 0.1
Status: Draft

## Objective

Construct deterministic Seal artifact for a closed Event window.

## Steps

1. Resolve window boundaries.
2. Recompute Event commitment over window.
3. Build canonical Seal input.
4. Compute `seal_hash`.
5. Sign canonical Seal input.
6. Persist Seal with `prev_seal_hash` linkage.

## Constraint

Window content MUST be immutable at Seal creation time.
