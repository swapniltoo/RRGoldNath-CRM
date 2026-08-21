-- RR Gold Nath / Nath Catalogue Management Module
-- MySQL 8+ / MariaDB 10.5+
-- Stores relative image paths only. Files belong under Images/.

CREATE TABLE IF NOT EXISTS nath_categories (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  image_path VARCHAR(255),
  display_order INT NOT NULL DEFAULT 0,
  status ENUM('ACTIVE', 'HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS nath_items (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  category_id INT UNSIGNED NOT NULL,
  item_name VARCHAR(150) NOT NULL,
  slug VARCHAR(150) NOT NULL UNIQUE,
  item_code VARCHAR(50) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL,
  weight DECIMAL(5, 2),
  purity VARCHAR(10),
  metal VARCHAR(50),
  stone_type VARCHAR(100),
  description TEXT,
  primary_image VARCHAR(255),
  featured BOOLEAN NOT NULL DEFAULT FALSE,
  status ENUM('ACTIVE', 'HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  display_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_nath_items_category FOREIGN KEY (category_id) REFERENCES nath_categories(id) ON DELETE RESTRICT,
  INDEX idx_nath_items_category_status (category_id, status),
  INDEX idx_nath_items_search (item_name, item_code)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS nath_item_images (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  item_id INT UNSIGNED NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  display_order INT NOT NULL DEFAULT 0,
  is_primary BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_nath_item_images_item FOREIGN KEY (item_id) REFERENCES nath_items(id) ON DELETE CASCADE,
  INDEX idx_nath_item_images_item_order (item_id, display_order)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS crm_leads (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(150) NOT NULL,
  customer_email VARCHAR(190),
  customer_mobile VARCHAR(30) NOT NULL,
  product_id INT UNSIGNED,
  item_code VARCHAR(50),
  category_id INT UNSIGNED,
  category_name VARCHAR(100),
  message TEXT,
  status ENUM('NEW', 'CONTACTED', 'CONVERTED', 'CLOSED') NOT NULL DEFAULT 'NEW',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_crm_leads_product FOREIGN KEY (product_id) REFERENCES nath_items(id) ON DELETE SET NULL,
  CONSTRAINT fk_crm_leads_category FOREIGN KEY (category_id) REFERENCES nath_categories(id) ON DELETE SET NULL,
  INDEX idx_crm_leads_status (status),
  INDEX idx_crm_leads_item_code (item_code)
) ENGINE=InnoDB;

INSERT INTO nath_categories (name, slug, description, display_order) VALUES
('Marathi Nath', 'marathi-nath', 'Traditional Maharashtrian Nath designs', 1),
('Brahmani Nath', 'brahmani-nath', 'Brahmani Nath designs', 2),
('Peshwai Nath', 'peshwai-nath', 'Peshwai traditional Nath', 3),
('Kolhapuri Nath', 'kolhapuri-nath', 'Kolhapuri style Nath', 4),
('Pune Nath', 'pune-nath', 'Pune region Nath', 5),
('Rajasthani Nath', 'rajasthani-nath', 'Traditional Rajasthani Nath', 6),
('Rajputi Nath', 'rajputi-nath', 'Rajputi style Nath', 7),
('Punjabi Nath', 'punjabi-nath', 'Punjabi style Nath', 8),
('Bengali Nath', 'bengali-nath', 'Bengali Nath designs', 9),
('Kashmiri Nath', 'kashmiri-nath', 'Kashmiri style Nath', 10),
('Mukkuthi', 'mukkuthi', 'South Indian Mukkuthi designs', 11),
('Nathni', 'nathni', 'Traditional Nathni', 12),
('Bulak', 'bulak', 'Bulak nose jewellery', 13),
('Phuli', 'phuli', 'Phuli nose ornament', 14),
('Bridal Nath', 'bridal-nath', 'Bridal Nath collection', 15),
('Kundan Nath', 'kundan-nath', 'Kundan work Nath', 16),
('Polki Nath', 'polki-nath', 'Polki stone Nath', 17),
('Jadau Nath', 'jadau-nath', 'Jadau design Nath', 18),
('Meenakari Nath', 'meenakari-nath', 'Meenakari decorated Nath', 19),
('Pearl Nath', 'pearl-nath', 'Pearl adorned Nath', 20),
('Diamond Nath', 'diamond-nath', 'Diamond studded Nath', 21)
ON DUPLICATE KEY UPDATE description = VALUES(description), display_order = VALUES(display_order);
