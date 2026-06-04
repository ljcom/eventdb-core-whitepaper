# AGENTS.md

Instruksi ini berlaku untuk seluruh repository ini.

## Workflow Wajib

- Selalu cek status kerja dengan `git status --short --branch` sebelum mengubah file.
- Setelah tugas selesai dan perubahan sudah diverifikasi secara wajar, buat commit Git.
- Jangan commit perubahan yang tidak terkait dengan tugas.
- Jangan commit file dari nested Git repository seperti `eventdb/` dari repository luar.
- Jika ada perubahan user yang sudah ada sebelumnya, jangan ubah atau masukkan ke commit kecuali memang bagian dari tugas.

## Configuration-First

- Semua nilai environment, koneksi database, feature flag, port, credential, dan provider harus lewat konfigurasi.
- Jangan hardcode connection string, secret, API key, nama host, atau provider runtime di source code.
- Untuk app Node.js, gunakan `src/config.js` sebagai sumber konfigurasi utama.
- Perubahan behavior runtime harus bisa dikendalikan lewat env var yang terdokumentasi.
- Default harus aman dan mempertahankan behavior lama kecuali tugas meminta perubahan.

## Konsistensi API

- Jangan ubah struktur endpoint, request body, response body, atau error code tanpa instruksi eksplisit.
- Jika menambah backend storage atau adapter baru, pertahankan kontrak API publik.
- Validasi compatibility harus mempertimbangkan client lama.

## Database dan Adapter

- Akses database harus melewati layer adapter, bukan langsung tersebar di handler API jika ada opsi multi-engine.
- Query engine-specific harus diisolasi dalam adapter atau helper khusus.
- PostgreSQL tetap menjadi default sampai MSSQL dinyatakan stabil.
- Dukungan MSSQL harus menjaga hasil verifikasi yang ekuivalen dengan PostgreSQL untuk data yang sama.
- JSON dan timestamp harus dinormalisasi sebelum dipakai untuk hashing atau verification.

## Kualitas Perubahan

- Buat perubahan minimal, fokus pada akar masalah.
- Ikuti style kode yang sudah ada.
- Update dokumentasi saat behavior, setup, env var, atau workflow berubah.
- Tambahkan test hanya jika codebase sudah punya pola test yang relevan.
- Jalankan validasi paling spesifik yang tersedia untuk file yang diubah.

## Git

- Gunakan pesan commit yang jelas dan ringkas.
- Jangan membuat branch baru kecuali diminta.
- Jangan push kecuali diminta.
- Jika repository sedang behind remote, jangan pull otomatis kecuali diminta.
