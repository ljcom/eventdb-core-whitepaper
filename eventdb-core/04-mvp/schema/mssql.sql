-- EventDB Core MVP Schema (MSSQL)
-- Version: 0.1

if not exists (select * from sys.objects where object_id = object_id(N'[dbo].[eventdb_event]') and type in (N'U'))
begin
  create table [dbo].[eventdb_event] (
    [chain_id] nvarchar(200) not null,
    [event_id] nvarchar(200) not null,
    [sequence] bigint not null,
    [prev_hash] nvarchar(256) not null,
    [account_id] nvarchar(200) not null,
    [event_type] nvarchar(200) not null,
    [event_time] datetime2 not null,
    [payload] nvarchar(max) not null,
    [signature] nvarchar(max) not null,
    constraint [pk_eventdb_event] primary key ([chain_id], [sequence]),
    constraint [uq_eventdb_event_id] unique ([chain_id], [event_id])
  );
end

go

if not exists (select * from sys.indexes where name = N'ix_eventdb_event_chain_time' and object_id = object_id(N'[dbo].[eventdb_event]'))
begin
  create index [ix_eventdb_event_chain_time] on [dbo].[eventdb_event] ([chain_id], [event_time]);
end

go

if not exists (select * from sys.objects where object_id = object_id(N'[dbo].[eventdb_seal]') and type in (N'U'))
begin
  create table [dbo].[eventdb_seal] (
    [chain_id] nvarchar(200) not null,
    [window_id] nvarchar(200) not null,
    [window_start_sequence] bigint not null,
    [window_end_sequence] bigint not null,
    [prev_seal_hash] nvarchar(256) not null,
    [window_commitment_hash] nvarchar(256) not null,
    [seal_hash] nvarchar(256) not null,
    [account_id] nvarchar(200) not null,
    [seal_time] datetime2 not null,
    [signature] nvarchar(max) not null,
    constraint [pk_eventdb_seal] primary key ([chain_id], [window_id]),
    constraint [uq_eventdb_seal_endseq] unique ([chain_id], [window_end_sequence])
  );
end

go

if not exists (select * from sys.objects where object_id = object_id(N'[dbo].[eventdb_snapshot]') and type in (N'U'))
begin
  create table [dbo].[eventdb_snapshot] (
    [chain_id] nvarchar(200) not null,
    [snapshot_id] nvarchar(200) not null,
    [basis_sequence] bigint not null,
    [basis_seal_hash] nvarchar(256) null,
    [snapshot_time] datetime2 not null,
    [snapshot_hash] nvarchar(256) not null,
    [snapshot_data] nvarchar(max) not null,
    [signature] nvarchar(max) not null,
    constraint [pk_eventdb_snapshot] primary key ([chain_id], [snapshot_id])
  );
end
GO
