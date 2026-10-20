CREATE DATABASE IF NOT EXISTS uts_portal_berita
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE uts_portal_berita;

-- Tabel Induk 1
CREATE TABLE users (
  user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name    VARCHAR(100) NOT NULL,
  email   VARCHAR(150) NOT NULL,
  role    VARCHAR(50)  NOT NULL,
  PRIMARY KEY (user_id),
  UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB;

-- Tabel Induk 2
-- (category_id tetap ada, tanpa FK karena tabel kategori tidak termasuk 3 tabel UTS)
CREATE TABLE artikel (
  article_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category_id  INT UNSIGNED NULL,
  title        VARCHAR(255) NOT NULL,
  published_at DATETIME NULL,
  status       ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
  PRIMARY KEY (article_id)
) ENGINE=InnoDB;

-- Tabel Transaksi/Anak (menghubungkan artikel dan users)
CREATE TABLE artikel_penulis (
  article_id    INT UNSIGNED NOT NULL,
  user_id       INT UNSIGNED NOT NULL,
  peran_penulis VARCHAR(50)  NOT NULL,
  PRIMARY KEY (article_id, user_id),
  CONSTRAINT fk_ap_artikel FOREIGN KEY (article_id)
    REFERENCES artikel (article_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_ap_users FOREIGN KEY (user_id)
    REFERENCES users (user_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
