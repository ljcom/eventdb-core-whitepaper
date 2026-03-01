-- EventDB Core MVP Schema (PostgreSQL)
-- Version: 0.2
-- Namespace-aware integrity schema (ledger boundary only)

create table if not exists namespaces (
  namespace_id text primary key,
  name text null,
  created_at timestamptz not null default now()
);

insert into namespaces (namespace_id, name)
values ('default', 'Default Namespace')
on conflict (namespace_id) do nothing;

create table if not exists eventdb_chain (
  namespace_id text not null references namespaces(namespace_id),
  chain_id text not null,
  created_at timestamptz not null default now(),
  primary key (namespace_id, chain_id)
);

create table if not exists eventdb_event (
  namespace_id text not null,
  chain_id text not null,
  event_id text not null,
  sequence bigint not null,
  prev_hash text not null,
  account_id text not null,
  event_type text not null,
  event_time timestamptz not null,
  payload jsonb not null,
  signature text not null,
  primary key (namespace_id, chain_id, sequence),
  unique (namespace_id, chain_id, event_id),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id)
);

create index if not exists idx_eventdb_event_ns_chain_time
  on eventdb_event (namespace_id, chain_id, event_time);

create table if not exists eventdb_seal (
  namespace_id text not null,
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
  primary key (namespace_id, chain_id, window_id),
  unique (namespace_id, chain_id, window_end_sequence),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id)
);

create index if not exists idx_eventdb_seal_ns_chain_time
  on eventdb_seal (namespace_id, chain_id, seal_time);

create table if not exists eventdb_snapshot (
  namespace_id text not null,
  chain_id text not null,
  snapshot_id text not null,
  basis_sequence bigint not null,
  basis_seal_hash text,
  snapshot_time timestamptz not null,
  snapshot_hash text not null,
  snapshot_data jsonb not null,
  signature text not null,
  primary key (namespace_id, chain_id, snapshot_id),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id)
);

create index if not exists idx_eventdb_snapshot_ns_chain_time
  on eventdb_snapshot (namespace_id, chain_id, snapshot_time);
