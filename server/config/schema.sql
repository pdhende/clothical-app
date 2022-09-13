/*
Database design for Clothical can be divided broadly into
core functions necessary for facilitating day-to-day operations
of the e-commerce platform and additional functions which can 
be described as the nice-to-have functions for the platform.

Core functions include:
 -- user management
 -- product and inventory management
 -- shopping cart function
 -- payment management

 Additional functions include:
 -- marketing functions
 -- help desk and support
 -- third-party integrations

 I doubt we'll include any of the nice-to-have functions for our platform, but not certain yet

On the subject of the shopping cart, it should consider static data, session data, and processed
data. STATIC data will comprise the following data tables:
 -- product table
 -- discount table
 -- customer table

 SESSION data will comprise the following data tables:
 -- shopping_session table
 -- cart_item table

 PROCESSED data will comprise the following data tables:
  -- order_details table
  -- order_items table
  -- payment_details table

*/

DROP DATABASE IF EXISTS clothical_db;
CREATE DATABASE clothical_db;
USE clothical_db;
-- ---------------------------------------------------

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    user_email VARCHAR(30) NOT NULL UNIQUE,
    user_password VARCHAR(20) NOT NULL,
    first_name VARCHAR(20)  NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    date_registered TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO
	customer (user_name, user_email, user_password, first_name, last_name, telephone)
VALUES
	('jcompagnoni', 'jcomp_03@yahoo.com', 'secretpassword', 'James', 'Compagnoni', '1234567890'),
	('anotheruser', 'user@test.com', 'secretpassword', 'User', 'Name', '1234567890');
-- ---------------------------------------------------

DROP TABLE IF EXISTS customer_address;
CREATE TABLE customer_address (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    customer_address VARCHAR(50),
    city VARCHAR(20),
    postal_code VARCHAR(20),
    country VARCHAR(20),
    telephone VARCHAR(20),
    mobile VARCHAR(20),
    CONSTRAINT fk_CUSTOMER_ADDRESS_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO
	customer_address (customer_id, customer_address, city, postal_code, country, telephone, mobile)
VALUES
	(1, '123 Main Street', 'Some city', 'Some postal code', 'USA', '1234567890', '1234567890'),
    (2, '321 Side Street', 'Another city', 'Another postal code', 'USA', 123456890, '123467890');
-- ---------------------------------------------------

DROP TABLE IF EXISTS customer_payment;
CREATE TABLE customer_payment (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    customer_address VARCHAR(50),
    payment_type ENUM('Credit card', 'Debit card', 'Stripe', 'Paypal'),
    merchant VARCHAR(20),
    account_no INTEGER,
    expiry DATE,
    CONSTRAINT fk_CUSTOMER_PAYMENT_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO
	customer_payment (customer_id, customer_address, payment_type, merchant, account_no, expiry)
VALUES
	(1, '123 Main Street', 'Credit card', 'Some merchant', 010010001, '2021-09-28'),
    (2, '321 Side Street', NULL, 'Another merchant', 12300123, '2023-01-01');
-- ---------------------------------------------------

DROP TABLE IF EXISTS payment_details;
CREATE TABLE payment_details (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INTEGER,
    amount DECIMAL(7,2),
    merchant VARCHAR(20),
    status VARCHAR(20)
);
INSERT INTO
	payment_details (order_id, amount, merchant, status)
VALUES
	(01023, 43.99, 'Some merchant', 'A status value'),
    (9912, 99999.99, 'Another merchant', 'Closed'),
    (4321, 10000.01, 'Test merchant', 'Open');
-- ---------------------------------------------------

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    payment_id INTEGER,
	order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ORDER_DETAILS_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ORDER_DETAILS_payment_id_refs_PAYMENT_DETAILS FOREIGN KEY (payment_id) REFERENCES payment_details(id) ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO
	order_details (customer_id, payment_id)
VALUES
	(1, 1, '2018-03-01'),
    (2, 2, '2020-10-23'),
    (2, 3, '2022-07-18');
-- ---------------------------------------------------

DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(100) DEFAULT ''
);
INSERT INTO 
	product_category (name)
VALUES
	('Men\'s pants'),
    ('Men\'s shorts'),
    ('Men\'s T-shirts'),
    ('Men\'s dress shirts'),
    ('Men\'s shoes'),
	('Women\'s pants'),
    ('Women\'s shorts'),
    ('Women\'s T-shirts'),
    ('Women\'s dress shirts'),
    ('Women\'s shoes');
-- ---------------------------------------------------

DROP TABLE IF EXISTS product_inventory;
CREATE TABLE product_inventory (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantity INTEGER NOT NULL DEFAULT 0
);
INSERT INTO
	product_inventory (quantity)
VALUES
	(1),
    (2),
    (3),
    (4),
    (5);
-- ---------------------------------------------------

DROP TABLE IF EXISTS product_discount;
CREATE TABLE product_discount (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20) NOT NULL DEFAULT 'A discount',
    description VARCHAR(100) DEFAULT '', 
    discount_percent DECIMAL(2,0) DEFAULT 0,
    active BOOLEAN DEFAULT 0
);
INSERT INTO
	product_discount (description, discount_percent, active)
VALUES
	('The discount description goes here', 15, 1);

-- ---------------------------------------------------

DROP TABLE IF EXISTS product;
CREATE TABLE product (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    cart_description VARCHAR(100) NOT NULL,
    description VARCHAR(200) NOT NULL,
    sku VARCHAR(20) DEFAULT 'SKU-Default',
    price DECIMAL(7,2),
    category_id INTEGER,
    inventory_id INTEGER,
    discount_id INTEGER,
    CONSTRAINT fk_PRODUCT_category_id_refs_PRODUCT_CATEGORY FOREIGN KEY (category_id) REFERENCES product_category(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_PRODUCT_inventory_id_refs_PRODUCT_INVENTORY FOREIGN KEY (inventory_id) REFERENCES product_inventory(id) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_PRODUCT_discount_id_refs_PRODUCT_DISCOUNT FOREIGN KEY (discount_id) REFERENCES product_discount(id) ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO
	product( name, cart_description, description, price, category_id, inventory_id, discount_id)
VALUES
	('Button-downed shirt', 'Description for button-downed plaid shirt when in cart',
    'A longer description for the button-downed plaid shirt when displayed in its card', 36.95,
    4, 2, 1);
-- ---------------------------------------------------

DROP TABLE IF EXISTS shopping_session;
CREATE TABLE shopping_session (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    total DECIMAL(7,2),
    CONSTRAINT fk_SHOPPING_SESSION_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO
	shopping_session (customer_id, total)
VALUES
	(2, 24.99);
-- ---------------------------------------------------
DROP TABLE IF EXISTS cart_item;
CREATE TABLE cart_item (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    session_id INTEGER,
    product_id INTEGER,
    CONSTRAINT fk_CART_ITEM_session_id_refs_SHOPPING_SESSION FOREIGN KEY (session_id) REFERENCES shopping_session(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_CART_ITEM_product_id_refs_PRODUCT FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO
	cart_item (session_id, product_id)
VALUES
	(1, 1);
-- ---------------------------------------------------

DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    CONSTRAINT fk_ORDER_ITEMS_order_id_refs_ORDER_DETAILS FOREIGN KEY (order_id) REFERENCES order_details(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_ORDER_ITEMS_product_id_refs_PRODUCT FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO
	order_items (order_id, product_id) 
VALUES
	(3, 1),
    (1, 1);
    