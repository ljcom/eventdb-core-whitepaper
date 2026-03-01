# 0002_add_namespace.md
EventDB Core - Migration Note: Add Ledger Namespace
Version: 0.1
Status: Draft

## Scope

This migration introduces `namespace_id` as a ledger boundary field.
Existing records are backfilled with `namespace_id = 'default'`.

## Backfill Plan (Existing Database)

1. Create `namespaces` table and seed `('default', 'Default Namespace')`.
2. Create `eventdb_chain(namespace_id, chain_id)`.
3. Insert distinct chain rows into `eventdb_chain` using `namespace_id = 'default'` from existing event/seal/snapshot chain IDs.
4. Add nullable `namespace_id` column to `eventdb_event`, `eventdb_seal`, and `eventdb_snapshot`.
5. Backfill all existing rows with `namespace_id = 'default'`.
6. Set `namespace_id` to `NOT NULL` on all three tables.
7. Replace existing primary keys and unique constraints to include `namespace_id`.
8. Add composite foreign keys `(namespace_id, chain_id)` to `eventdb_chain(namespace_id, chain_id)`.
9. Add namespace-aware indexes for verification paths.

## Integrity Notes

- Namespace is a ledger boundary only.
- Hash calculation rules remain unchanged.
- Seal mechanics remain unchanged.
- No business logic is introduced.
