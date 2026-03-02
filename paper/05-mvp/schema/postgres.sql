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

create table if not exists projection_registry (
  projection_name text not null,
  projection_ver integer not null,
  logic_checksum text not null,
  rebuild_strategy text not null default 'full_rebuild',
  migration_policy text not null default 'replay_only',
  status text not null default 'active',
  created_at timestamptz not null default now(),
  primary key (projection_name, projection_ver)
);

alter table projection_registry
  add column if not exists rebuild_strategy text not null default 'full_rebuild';

alter table projection_registry
  add column if not exists migration_policy text not null default 'replay_only';

create table if not exists projection_checkpoint (
  namespace_id text not null references namespaces(namespace_id),
  chain_id text not null,
  projection_name text not null,
  projection_ver integer not null,
  last_sequence bigint not null default 0,
  updated_at timestamptz not null default now(),
  primary key (namespace_id, chain_id, projection_name, projection_ver),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id),
  foreign key (projection_name, projection_ver)
    references projection_registry(projection_name, projection_ver)
);

create index if not exists idx_projection_checkpoint_ns_chain
  on projection_checkpoint (namespace_id, chain_id, projection_name, projection_ver, last_sequence);

create schema if not exists read;

create table if not exists read.orders_v1 (
  namespace_id text not null references namespaces(namespace_id),
  chain_id text not null,
  order_id text not null,
  status text not null,
  updated_at timestamptz not null,
  source_event_id text not null,
  source_sequence bigint not null,
  projection_ver integer not null,
  primary key (namespace_id, chain_id, order_id),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id)
);

create index if not exists idx_read_orders_v1_ns_chain_status_time
  on read.orders_v1 (namespace_id, chain_id, status, updated_at desc);

create table if not exists sql_write_idempotency (
  namespace_id text not null references namespaces(namespace_id),
  chain_id text not null,
  idempotency_key text not null,
  statement_hash text not null,
  event_id text not null,
  created_at timestamptz not null default now(),
  primary key (namespace_id, chain_id, idempotency_key),
  foreign key (namespace_id, chain_id)
    references eventdb_chain(namespace_id, chain_id)
);
