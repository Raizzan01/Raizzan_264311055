-- 1. Tabel Master Kategori
CREATE TABLE IF NOT EXISTS kategori (
    category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabel Superclass Users (Hasil Spesialisasi Single Table / Inherited Class)
CREATE TABLE IF NOT EXISTS users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'penulis'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel Subclass Reporter
CREATE TABLE IF NOT EXISTS reporter (
    user_id INT UNSIGNED PRIMARY KEY,
    bidang_liputan VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabel Subclass Editor
CREATE TABLE IF NOT EXISTS editor (
    user_id INT UNSIGNED PRIMARY KEY,
    level_editor VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabel Master Artikel
CREATE TABLE IF NOT EXISTS artikel (
    article_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    published_at DATETIME NULL,
    status ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
    CONSTRAINT fk_artikel_kategori FOREIGN KEY (category_id) 
        REFERENCES kategori(category_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Tabel Asosiatif / Weak Entity (Relasi Many-to-Many Artikel & Users)
CREATE TABLE IF NOT EXISTS artikel_penulis (
    article_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    peran_penulis VARCHAR(50) NOT NULL,
    PRIMARY KEY (article_id, user_id),
    CONSTRAINT fk_artpen_artikel FOREIGN KEY (article_id) 
        REFERENCES artikel(article_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_artpen_users FOREIGN KEY (user_id) 
        REFERENCES users(user_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Tabel Denormalisasi / Rekapitulasi Produktivitas Penulis
CREATE TABLE IF NOT EXISTS rekap_produktivitas_penulis (
    user_id INT UNSIGNED PRIMARY KEY,
    nama_penulis VARCHAR(100) NOT NULL,
    total_artikel_published INT UNSIGNED DEFAULT 0,
    CONSTRAINT fk_rekap_user FOREIGN KEY (user_id) 
        REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
