-- EventDB Core MVP Schema (PostgreSQL)
-- Version: 0.1

create table if not exists eventdb_event (
  chain_id text not null,
  event_id text not null,
  sequence bigint not null,
  prev_hash text not null,
  account_id text not null,
  event_type text not null,
  event_time timestamptz not null,
  payload jsonb not null,
  signature text not null,
  primary key (chain_id, sequence),
  unique (chain_id, event_id)
);

create index if not exists idx_eventdb_event_chain_time
  on eventdb_event (chain_id, event_time);

create table if not exists eventdb_seal (
  chain_id text not null,
  window_id text not null,
  window_start_sequence bigint not null,
  window_end_sequence bigint not null,
  prev_seal_hash text not null,
  window_commitment_hash text not null,
  seal_hash text not null,
  account_id text not null,
  seal_time timestamptz not null,
  signature text not null,
  primary key (chain_id, window_id),
  unique (chain_id, window_end_sequence)
);

create table if not exists eventdb_snapshot (
  chain_id text not null,
  snapshot_id text not null,
  basis_sequence bigint not null,
  basis_seal_hash text,
  snapshot_time timestamptz not null,
  snapshot_hash text not null,
  snapshot_data jsonb not null,
  signature text not null,
  primary key (chain_id, snapshot_id)
);
