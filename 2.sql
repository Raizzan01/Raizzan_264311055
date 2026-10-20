-- [CREATE] minimal 3 baris per tabel (urutan: induk dulu, baru transaksi)
INSERT INTO users (user_id, name, email, role) VALUES
  (1, 'Raizzan Ulayya Taqqi', 'raizzan@example.com', 'reporter'),
  (2, 'Siti Aminah',          'siti@example.com',    'editor'),
  (3, 'Budi Santoso',         'budi@example.com',    'reporter');

INSERT INTO artikel (article_id, category_id, title, published_at, status) VALUES
  (1, 1, 'Harga Beras Naik Jelang Akhir Tahun', '2026-10-01 08:00:00', 'published'),
  (2, 2, 'Politeknik Negeri Madiun Raih Akreditasi', '2026-10-05 09:30:00', 'published'),
  (3, 1, 'Jadwal Pasar Murah Pekan Depan', NULL, 'draft');

INSERT INTO artikel_penulis (article_id, user_id, peran_penulis) VALUES
  (1, 1, 'Penulis Utama'),
  (2, 1, 'Penulis Utama'),
  (3, 2, 'Penulis Utama'),
  (3, 3, 'Editor'),
  (2, 3, 'Kontributor');

-- [READ] seluruh isi salah satu tabel induk
SELECT * FROM users;

-- [UPDATE] ubah satu data di tabel transaksi (WHERE pada Primary Key komposit)
UPDATE artikel_penulis
SET peran_penulis = 'Penyunting'
WHERE article_id = 3 AND user_id = 3;

-- [DELETE] hapus satu baris dummy di tabel transaksi (WHERE wajib)
DELETE FROM artikel_penulis
WHERE article_id = 2 AND user_id = 3;
