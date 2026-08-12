-- Create database if not exists
CREATE DATABASE IF NOT EXISTS laptopshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE laptopshop;

-- Drop tables if exists (để tránh lỗi khi rebuild)
DROP TABLE IF EXISTS SPRING_SESSION_ATTRIBUTES;
DROP TABLE IF EXISTS SPRING_SESSION;
DROP TABLE IF EXISTS order_detail;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart_detail;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

-- Create roles table
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    name VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create users table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    avatar VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    role_id BIGINT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create products table
CREATE TABLE products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    image VARCHAR(255),
    detail_desc TEXT,
    short_desc VARCHAR(500),
    quantity BIGINT,
    factory VARCHAR(255),
    target VARCHAR(255),
    sold BIGINT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create carts table
CREATE TABLE carts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sum DOUBLE DEFAULT 0,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create cart_detail table
CREATE TABLE cart_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    price DOUBLE NOT NULL,
    quantity BIGINT NOT NULL,
    cart_id BIGINT,
    product_id BIGINT,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create orders table
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    receiver_address VARCHAR(255),
    receiver_name VARCHAR(255),
    receiver_phone VARCHAR(255),
    status VARCHAR(255),
    total_price DOUBLE,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create order_detail table
CREATE TABLE order_detail (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    price DOUBLE NOT NULL,
    quantity BIGINT NOT NULL,
    order_id BIGINT,
    product_id BIGINT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create Spring Session tables
CREATE TABLE SPRING_SESSION (
    PRIMARY_ID CHAR(36) NOT NULL,
    SESSION_ID CHAR(36) NOT NULL,
    CREATION_TIME BIGINT NOT NULL,
    LAST_ACCESS_TIME BIGINT NOT NULL,
    MAX_INACTIVE_INTERVAL INT NOT NULL,
    EXPIRY_TIME BIGINT NOT NULL,
    PRINCIPAL_NAME VARCHAR(100),
    CONSTRAINT SPRING_SESSION_PK PRIMARY KEY (PRIMARY_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE UNIQUE INDEX SPRING_SESSION_IX1 ON SPRING_SESSION (SESSION_ID);
CREATE INDEX SPRING_SESSION_IX2 ON SPRING_SESSION (EXPIRY_TIME);
CREATE INDEX SPRING_SESSION_IX3 ON SPRING_SESSION (PRINCIPAL_NAME);

CREATE TABLE SPRING_SESSION_ATTRIBUTES (
    SESSION_PRIMARY_ID CHAR(36) NOT NULL,
    ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
    ATTRIBUTE_BYTES BLOB NOT NULL,
    CONSTRAINT SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
    CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES SPRING_SESSION(PRIMARY_ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert initial data for roles
INSERT INTO roles (name, description) VALUES 
('ADMIN', 'Administrator role with full access'),
('USER', 'Regular user role with limited access');

-- Insert admin user (password: 123456 - bcrypt hashed)
INSERT INTO users (email, password, full_name, address, phone, avatar, role_id) VALUES 
('admin@gmail.com', '$2a$10$7Cw/v8TYf6PxHqIxKqYjJ.M6n4aXApQfpEgCJ8PshZzwMlKenZQEC', 'Admin User', '123 Admin Street', '0123456789', 'admin-avatar.jpg', 1);

-- Insert sample products
INSERT INTO products (name, price, image, detail_desc, short_desc, quantity, factory, target, sold) VALUES 
('Dell Inspiron 15 3000', 12000000, 'dell-inspiron-15.jpg', 'Laptop Dell Inspiron 15 3000 với hiệu năng ổn định, phù hợp cho công việc văn phòng và học tập.', 'Laptop văn phòng giá rẻ', 50, 'DELL', 'VANPHONG', 0),
('HP Pavilion Gaming 15', 18000000, 'hp-pavilion-gaming.jpg', 'Laptop gaming HP Pavilion 15 với card đồ họa rời GTX 1650, phù hợp cho game thủ.', 'Laptop gaming tầm trung', 30, 'HP', 'GAMING', 0),
('Lenovo ThinkPad X1 Carbon', 35000000, 'lenovo-thinkpad-x1.jpg', 'Laptop Lenovo ThinkPad X1 Carbon cao cấp, mỏng nhẹ, phù hợp cho doanh nhân.', 'Laptop cao cấp cho doanh nhân', 20, 'LENOVO', 'DOANHNHAN', 0),
('ASUS ROG Strix G15', 28000000, 'asus-rog-strix.jpg', 'Laptop gaming ASUS ROG Strix G15 với RTX 3060, hiệu năng mạnh mẽ.', 'Laptop gaming cao cấp', 15, 'ASUS', 'GAMING', 0),
('MacBook Air M2', 28000000, 'macbook-air-m2.jpg', 'MacBook Air M2 2023 với chip Apple Silicon, mỏng nhẹ, pin lâu.', 'Laptop Apple cao cấp', 25, 'APPLE', 'DOANHNHAN', 0),
('Acer Aspire 5', 10000000, 'acer-aspire-5.jpg', 'Laptop Acer Aspire 5 giá rẻ, phù hợp cho sinh viên và văn phòng.', 'Laptop giá rẻ cho sinh viên', 40, 'ACER', 'SINHVIEN', 0);

-- Show all tables
SELECT 'Tables created successfully!' AS message;
SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'laptopshop';
