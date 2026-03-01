# canonical-json.md
EventDB Core MVP Script Notes - Canonical JSON
Version: 0.1
Status: Draft

## Objective

Define deterministic JSON normalization for hashing and signature input.

## Rules

- Keys MUST be sorted lexicographically.
- Input MUST be UTF-8 without BOM.
- Whitespace formatting MUST NOT affect canonical bytes.
- Duplicate keys MUST cause failure.

## Output

The process MUST emit one canonical byte representation for equivalent logical input.
