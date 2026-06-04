# TODO: Persiapan Support MSSQL

Tujuan: menambahkan dukungan MSSQL tanpa mengubah struktur API HTTP yang sudah ada. API publik tetap sama; perubahan dibatasi pada konfigurasi, storage adapter, schema, dan test.

## 1. Keputusan Desain

- [ ] Tetapkan env selector: `DB_DRIVER=postgres|mssql`.
- [ ] Pertahankan `DATABASE_URL` sebagai connection string utama.
- [ ] Pertahankan kontrak internal `query(sql, params)` dan `withTx(fn)`.
- [ ] Hindari perubahan endpoint, request body, response shape, dan error code.
- [ ] Dokumentasikan status dukungan: PostgreSQL stabil, MSSQL adapter baru.

## 2. Database Adapter Layer

- [ ] Refactor `eventdb/mvp-node/src/db.js` menjadi factory adapter.
- [ ] Buat adapter PostgreSQL terpisah, misalnya `src/db/postgres.js`.
- [ ] Buat adapter MSSQL terpisah, misalnya `src/db/mssql.js`.
- [ ] Samakan return shape MSSQL agar kompatibel dengan pola `{ rows }`.
- [ ] Samakan client transaction API agar `client.query(...)` tetap bisa dipakai.
- [ ] Tambahkan dependency MSSQL Node.js, misalnya package `mssql`.

## 3. Query Portability

- [ ] Inventaris semua query PostgreSQL-specific di `src/app.js`.
- [ ] Inventaris semua query PostgreSQL-specific di `src/builders.js`.
- [ ] Inventaris semua query PostgreSQL-specific di `src/verification.js`.
- [ ] Inventaris semua query PostgreSQL-specific di `src/projections.js`.
- [ ] Inventaris semua query PostgreSQL-specific di `src/sql-write-adapter.js`.
- [ ] Ganti placeholder `$1`, `$2`, dst. dengan helper adapter-specific.
- [ ] Abstraksikan `on conflict` menjadi helper upsert.
- [ ] Abstraksikan `limit` menjadi helper adapter-specific.
- [ ] Abstraksikan `for update` / locking semantics untuk PostgreSQL dan MSSQL.
- [ ] Abstraksikan `now()` / timestamp default.
- [ ] Hilangkan cast PostgreSQL seperti `max(sequence)::bigint`.

## 4. Schema MSSQL

- [ ] Update `paper/05-mvp/schema/mssql.sql` agar setara dengan schema runtime PostgreSQL.
- [ ] Tambahkan `namespace_id` ke semua table utama.
- [ ] Tambahkan table `eventdb_chain`.
- [ ] Tambahkan table `projection_registry`.
- [ ] Tambahkan table `projection_checkpoint`.
- [ ] Tambahkan table `sql_write_idempotency`.
- [ ] Tambahkan schema/table read model `read.orders_v1` atau mapping ekuivalen.
- [ ] Pastikan constraint primary key dan unique key setara dengan PostgreSQL.
- [ ] Pastikan index MSSQL setara untuk query verifikasi dan projection.
- [ ] Tentukan storage JSON: `nvarchar(max)` dengan serialize/parse eksplisit.

## 5. Schema Application Script

- [ ] Refactor `scripts/apply-schema.js` agar memilih schema berdasarkan `DB_DRIVER`.
- [ ] Pisahkan path schema PostgreSQL dan MSSQL.
- [ ] Hindari asumsi database admin PostgreSQL saat `DB_DRIVER=mssql`.
- [ ] Tambahkan instruksi pembuatan database MSSQL secara manual atau script aman.
- [ ] Pastikan batch separator `GO` pada MSSQL diproses benar.

## 6. JSON dan Timestamp Normalization

- [ ] Pastikan payload event dari MSSQL di-parse menjadi object sebelum hashing.
- [ ] Pastikan snapshot_data dari MSSQL di-parse menjadi object sebelum verification.
- [ ] Pastikan timestamp MSSQL `datetime2` dikembalikan dalam bentuk UTC canonical.
- [ ] Tambahkan helper normalisasi row hasil DB sebelum masuk verification.

## 7. Projection dan Read Model

- [ ] Port upsert `read.orders_v1` ke MSSQL.
- [ ] Port checkpoint locking ke MSSQL.
- [ ] Pastikan incremental projection tetap deterministik.
- [ ] Pastikan query read model tetap menghasilkan response identik.
- [ ] Pastikan SQL write adapter tetap append event lebih dulu, bukan mutasi read model langsung.

## 8. Docker dan Local Dev

- [ ] Tambahkan service MSSQL opsional di `docker-compose.yml`.
- [ ] Tambahkan contoh `.env` untuk PostgreSQL.
- [ ] Tambahkan contoh `.env` untuk MSSQL.
- [ ] Dokumentasikan perintah menjalankan PostgreSQL dan MSSQL bergantian.
- [ ] Pastikan default tetap PostgreSQL agar alur lama tidak rusak.

## 9. Test Matrix

- [ ] Jalankan test existing terhadap PostgreSQL.
- [ ] Tambahkan test smoke MSSQL: health, append event, verify chain.
- [ ] Tambahkan test MSSQL untuk build seal.
- [ ] Tambahkan test MSSQL untuk build snapshot.
- [ ] Tambahkan test MSSQL untuk projection orders.
- [ ] Tambahkan test MSSQL untuk SQL write adapter.
- [ ] Pastikan output verification PostgreSQL dan MSSQL ekuivalen untuk sample yang sama.

## 10. Dokumentasi

- [ ] Update `eventdb/mvp-node/README.md` dari PostgreSQL-only menjadi multi-storage.
- [ ] Tambahkan tabel env var database.
- [ ] Tambahkan batasan MSSQL yang diketahui.
- [ ] Tambahkan langkah migrasi schema MSSQL.
- [ ] Tambahkan catatan bahwa API HTTP tidak berubah.

## Risiko Teknis Utama

- Placeholder parameter berbeda antara PostgreSQL dan MSSQL.
- Upsert semantics berbeda (`on conflict` vs `MERGE` / conditional insert).
- Locking sequence append harus tetap deterministik dan aman terhadap race condition.
- JSONB PostgreSQL tidak sama dengan `nvarchar(max)` MSSQL.
- Timestamp harus canonical agar hash tetap konsisten lintas engine.
- Schema MSSQL saat ini belum setara dengan schema runtime PostgreSQL.

## Definition of Done

- [ ] `DB_DRIVER=postgres` tetap lulus test existing.
- [ ] `DB_DRIVER=mssql` bisa menjalankan schema, start API, dan lulus smoke test.
- [ ] Endpoint API tidak berubah.
- [ ] Verification result untuk sample data sama antara PostgreSQL dan MSSQL.
- [ ] README menjelaskan cara switch storage engine.
