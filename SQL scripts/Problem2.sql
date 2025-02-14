CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) UNIQUE NOT NULL,
    price NUMERIC(10, 2) NOT NULL,  -- Allows for decimal prices up to 999,999,999.99
    stock_quantity INTEGER NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    order_date DATE NOT NULL
);

CREATE TABLE order_items (
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id)  -- Composite primary key
);

-- Inserting products
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Laptop', 1200.00, 10),
('Tablet', 300.00, 20),
('Keyboard', 75.00, 30),
('Mouse', 25.00, 40),
('Monitor', 250.00, 15);


-- Inserting customers
INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Stevens', 'john.stevens@abcd.com'),
('Jane', 'Smith', 'jane.smith@abcd.com'),
('Peter', 'Jones', 'peter.jones@abcd.com'),
('Mary', 'Brown', 'mary.brown@abcd.com');

-- Inserting orders
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2025-02-01'),
(2, '2025-02-05'),
(3, '2025-02-10'),
(4, '2025-02-15'),
(1, '2025-02-20');

-- Inserting order items (multiple items per order)
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Order 1: 1 Laptop
(1, 3, 1),  -- Order 1: 1 Keyboard
(2, 2, 2),  -- Order 2: 2 Tablets
(3, 4, 3),  -- Order 3: 3 Mice
(4, 5, 1),  -- Order 4: 1 Monitor
(5, 2, 1), -- Order 5: 1 Tablet
(5, 3, 2); -- Order 5: 2 Keyboards

SELECT product_name, stock_quantity FROM products;

SELECT p.product_name, oi.quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
WHERE oi.order_id = 1;

SELECT o.id AS order_id, o.order_date, p.product_name, oi.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE c.id = 1;

UPDATE products p
SET stock_quantity = p.stock_quantity - oi.quantity
FROM order_items oi
WHERE p.id = oi.product_id AND oi.order_id = 1;

DELETE FROM order_items WHERE order_id = 1;
DELETE FROM orders WHERE id = 1;