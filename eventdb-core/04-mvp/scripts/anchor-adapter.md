# anchor-adapter.md
EventDB Core MVP Script Notes - Anchor Adapter
Version: 0.1
Status: Draft

## Objective

Publish and verify optional Anchor commitments using adapter abstraction.

## Adapter Contract

- Input MUST include local `chain_id`, checkpoint reference, and commitment hash.
- Publish operation MUST return external reference and external timestamp.
- Verify operation MUST compare local expected commitment with external commitment.

## Constraint

Anchor adapter MUST NOT alter local Chain or Seal integrity semantics.
