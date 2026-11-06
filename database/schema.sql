-- CMS Web Profil Sekolah
-- Database schema v1.0 | MySQL 5.7+ / MariaDB 10.3+
-- Jalankan sekali pada database kosong. Backup database sebelum menjalankan ulang.

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS roles (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_key VARCHAR(30) NOT NULL UNIQUE,
  role_name VARCHAR(80) NOT NULL,
  description VARCHAR(255) NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT UNSIGNED NOT NULL,
  full_name VARCHAR(120) NOT NULL,
  username VARCHAR(60) NOT NULL UNIQUE,
  email VARCHAR(120) NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  last_login_at DATETIME NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  INDEX idx_users_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS role_permissions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT UNSIGNED NOT NULL,
  permission_key VARCHAR(100) NOT NULL,
  created_at DATETIME NULL,
  UNIQUE KEY uq_role_permission (role_id, permission_key),
  CONSTRAINT fk_role_permissions_role FOREIGN KEY (role_id) REFERENCES roles(id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS school_profile (
  id TINYINT UNSIGNED PRIMARY KEY DEFAULT 1,
  school_name VARCHAR(180) NOT NULL DEFAULT 'Nama Sekolah',
  short_name VARCHAR(80) NULL,
  npsn VARCHAR(30) NULL,
  institution_level VARCHAR(80) NULL,
  accreditation VARCHAR(30) NULL,
  address TEXT NULL,
  village VARCHAR(100) NULL,
  district VARCHAR(100) NULL,
  city VARCHAR(100) NULL,
  province VARCHAR(100) NULL,
  postal_code VARCHAR(10) NULL,
  phone VARCHAR(40) NULL,
  email VARCHAR(120) NULL,
  website VARCHAR(180) NULL,
  logo_path VARCHAR(255) NULL,
  principal_name VARCHAR(120) NULL,
  about TEXT NULL,
  vision TEXT NULL,
  mission TEXT NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS site_settings (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  setting_key VARCHAR(120) NOT NULL UNIQUE,
  setting_value TEXT NULL,
  setting_group VARCHAR(60) NOT NULL DEFAULT 'general',
  updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pages (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  content LONGTEXT NULL,
  excerpt TEXT NULL,
  featured_image VARCHAR(255) NULL,
  status ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
  sort_order INT NOT NULL DEFAULT 0,
  created_by BIGINT UNSIGNED NULL,
  updated_by BIGINT UNSIGNED NULL,
  published_at DATETIME NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  CONSTRAINT fk_pages_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CONSTRAINT fk_pages_updated_by FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_pages_status_order (status, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS news_categories (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE,
  description TEXT NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS news_posts (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT UNSIGNED NULL,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(220) NOT NULL UNIQUE,
  excerpt TEXT NULL,
  content LONGTEXT NULL,
  featured_image VARCHAR(255) NULL,
  status ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
  is_featured TINYINT(1) NOT NULL DEFAULT 0,
  views BIGINT UNSIGNED NOT NULL DEFAULT 0,
  author_id BIGINT UNSIGNED NULL,
  published_at DATETIME NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  CONSTRAINT fk_news_category FOREIGN KEY (category_id) REFERENCES news_categories(id) ON DELETE SET NULL,
  CONSTRAINT fk_news_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_news_status_date (status, published_at),
  INDEX idx_news_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS announcements (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(220) NOT NULL UNIQUE,
  content LONGTEXT NULL,
  attachment_path VARCHAR(255) NULL,
  status ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
  start_date DATE NULL,
  end_date DATE NULL,
  author_id BIGINT UNSIGNED NULL,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  CONSTRAINT fk_announcements_author FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_announcements_status_dates (status, start_date, end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS staff (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  position VARCHAR(120) NULL,
  employment_type VARCHAR(80) NULL,
  employee_number VARCHAR(60) NULL,
  photo_path VARCHAR(255) NULL,
  biography TEXT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  INDEX idx_staff_active_order (is_active, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS facilities (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  slug VARCHAR(180) NOT NULL UNIQUE,
  description TEXT NULL,
  image_path VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  INDEX idx_facilities_active_order (is_active, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS achievements (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  recipient VARCHAR(150) NULL,
  level VARCHAR(80) NULL,
  award_date DATE NULL,
  description TEXT NULL,
  image_path VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_published TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  INDEX idx_achievements_published_date (is_published, award_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS galleries (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(180) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  description TEXT NULL,
  cover_image VARCHAR(255) NULL,
  event_date DATE NULL,
  is_published TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  INDEX idx_galleries_published_date (is_published, event_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS gallery_items (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  gallery_id BIGINT UNSIGNED NOT NULL,
  image_path VARCHAR(255) NOT NULL,
  caption VARCHAR(255) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  created_at DATETIME NULL,
  CONSTRAINT fk_gallery_items_gallery FOREIGN KEY (gallery_id) REFERENCES galleries(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_gallery_items_order (gallery_id, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS menus (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  menu_name VARCHAR(100) NOT NULL,
  location_key VARCHAR(50) NOT NULL DEFAULT 'main',
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  UNIQUE KEY uq_menu_location (menu_name, location_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS menu_items (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  menu_id BIGINT UNSIGNED NOT NULL,
  parent_id BIGINT UNSIGNED NULL,
  label VARCHAR(120) NOT NULL,
  url VARCHAR(255) NOT NULL DEFAULT '#',
  target VARCHAR(20) NOT NULL DEFAULT '_self',
  sort_order INT NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NULL,
  updated_at DATETIME NULL,
  CONSTRAINT fk_menu_items_menu FOREIGN KEY (menu_id) REFERENCES menus(id) ON DELETE CASCADE,
  CONSTRAINT fk_menu_items_parent FOREIGN KEY (parent_id) REFERENCES menu_items(id) ON DELETE SET NULL,
  INDEX idx_menu_items_order (menu_id, parent_id, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS media_library (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  original_name VARCHAR(255) NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  mime_type VARCHAR(120) NULL,
  file_size BIGINT UNSIGNED NOT NULL DEFAULT 0,
  alt_text VARCHAR(255) NULL,
  uploaded_by BIGINT UNSIGNED NULL,
  created_at DATETIME NULL,
  CONSTRAINT fk_media_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_media_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NULL,
  action VARCHAR(100) NOT NULL,
  entity_type VARCHAR(80) NULL,
  entity_id BIGINT UNSIGNED NULL,
  description TEXT NULL,
  ip_address VARCHAR(45) NULL,
  user_agent VARCHAR(255) NULL,
  created_at DATETIME NOT NULL,
  CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_audit_user_date (user_id, created_at),
  INDEX idx_audit_entity (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO roles (role_key, role_name, description, created_at, updated_at)
VALUES
('admin', 'Administrator', 'Akses penuh pengelolaan CMS', NOW(), NOW()),
('editor', 'Editor', 'Mengelola konten website', NOW(), NOW());

INSERT IGNORE INTO school_profile (id, school_name, created_at, updated_at)
VALUES (1, 'Nama Sekolah', NOW(), NOW());

SET FOREIGN_KEY_CHECKS = 1;
