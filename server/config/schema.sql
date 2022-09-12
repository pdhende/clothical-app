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

CREATE TABLE customer (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(20) NOT NULL,
    user_email VARCHAR(30) NOT NULL UNIQUE,
    user_password VARCHAR(20) NOT NULL,
    first_name VARCHAR(20)  NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    registration_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_address (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    customer_address VARCHAR(50),
    city VARCHAR(20),
    postal_code VARCHAR(20),
    country VARCHAR(20),
    telephone VARCHAR(20),
    mobile VARCHAR(20),
    CONSTRAINT fk_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE customer_payment (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    customer_address VARCHAR(50),
    payment_type ENUM('Credit card', 'Debit card', 'Stripe', 'Paypal'),
    merchant VARCHAR(20),
    account_no INTEGER,
    expiry DATE,
    CONSTRAINT fk_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE payment_details (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY,
    order_id INTEGER,
    amount DECIMAL(7,2),
    merchant VARCHAR(20),
    status VARCHAR(20)
);

-- Since order_details references foreign key in payment_details table, order_details table
-- must be created before it.
CREATE TABLE order_details (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    total DECIMAL(7,2),
    payment_id INTEGER,
    CONSTRAINT fk_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_payment_id_refs_PAYMENT_DETAILS FOREIGN KEY (payment_id) REFERENCES payment_details(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE product_category (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(100) DEFAULT '', 
);

CREATE TABLE product_inventory (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantity INTEGER NOT NULL DEFAULT 0,
);

CREATE TABLE product_discount (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(100) DEFAULT '', 
    discount_percent DECIMAL(2,0) DEFAULT 0,
    active BOOLEAN DEFAULT 0
);

-- Since product table references foreign keys in tables product_category, product_inventory, and 
-- product_discount, these tables must be created before it.
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
    CONSTRAINT fk_category_id_refs_PRODUCT_CATEGORY FOREIGN KEY (category_id) REFERENCES product_category(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_inventory_id_refs_PRODUCT_INVENTORY FOREIGN KEY (inventory_id) REFERENCES product_inventory(id) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_discount_id_refs_PRODUCT_DISCOUNT FOREIGN KEY (discount_id) REFERENCES product_discount(id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE shopping_session (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER,
    total DECIMAL(7,2),
    CONSTRAINT fk_customer_id_refs_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE cart_item (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    session_id INTEGER,
    product_id INTEGER,
    CONSTRAINT fk_session_id_refs_SHOPPING_SESSION FOREIGN KEY (session_id) REFERENCES shopping_session(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_product_id_refs_PRODUCT FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Since order_items table references foreign key in product table, product table 
-- must be created before it
CREATE TABLE order_items (
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    CONSTRAINT fk_order_id_refs_ORDER_DETAILS FOREIGN KEY (order_id) REFERENCES order_details(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_product_id_refs_PRODUCT FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

