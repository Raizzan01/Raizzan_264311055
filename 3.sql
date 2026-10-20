-- Laporan ringkasan
SELECT u.name, COUNT(ap.article_id) AS total_artikel
FROM artikel_penulis ap
JOIN users u ON ap.user_id = u.user_id
WHERE ap.peran_penulis = 'Penulis Utama'
GROUP BY u.user_id, u.name;

-- Hasil (setelah soal 2 dijalankan):
-- | name                 | total_artikel |
-- | Raizzan Ulayya Taqqi | 2             |
-- | Siti Aminah          | 1             |
