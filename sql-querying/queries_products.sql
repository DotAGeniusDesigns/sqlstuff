-- Insert chair
INSERT INTO products (name, price, can_be_returned)
VALUES ('chair', 44.00, false);

-- Insert stool
INSERT INTO products (name, price, can_be_returned)
VALUES ('stool', 25.99, true);

-- Insert table
INSERT INTO products (name, price, can_be_returned)
VALUES ('table', 124.00, false);

-- Display all of the rows and columns
SELECT * FROM products;

-- Display all of the names of the products
SELECT name FROM products;

-- Add new product
INSERT INTO products (name, price, can_be_returned)
VALUES ('beanbag', 45.99, false);

-- Display only products that can be returned
SELECT * FROM products WHERE can_be_returned;

-- Display only products with price less than $44
SELECT * FROM products WHERE price < 44.00;

-- Display only products with price between $22.50 and $99.99
SELECT * FROM products WHERE price BETWEEN 22.50 AND 99.99;

-- Make everything $20 off
UPDATE products SET price = GREATEST(price - 20.00, 1.00);

-- Remove all products less than $25
DELETE FROM products WHERE price < 25.00;

-- Increase all remaining products price by $20
UPDATE products SET price = price + 20.00;

-- Make everything returnable
UPDATE products SET can_be_returned = true;