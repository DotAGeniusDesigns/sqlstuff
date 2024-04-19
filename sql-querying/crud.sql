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

-----------------------------------------

-- Find app with ID of 1880
SELECT * FROM analytics WHERE id = 1880;

-- Find ID and app for all apps that were last updated on August 01, 2018
SELECT id, app_name FROM analytics WHERE last_updated  = '2018-08-01';

-- Count number of apps in each category
SELECT category, COUNT(category) FROM analytics GROUP BY category;

-- Find top 5 most reviewed apps and number of reviews for each
SELECT app_name FROM analytics ORDER BY reviews DESC LIMIT 5;

-- Find app that has most reviews with a rating greater than or equal to 4.8
SELECT app_name FROM analytics WHERE rating >= 4.8 ORDER BY reviews DESC LIMIT 1;

-- Find average rating for each category ordered by highest to lowest
SELECT category, AVG(rating) AS avg_rating FROM analytics GROUP BY category ORDER BY avg_rating DESC;

-- Find name, price, and rating of the most expensive app with rating less than 3
SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price DESC LIMIT 1;

-- Find names of all apps rated less than 3 with at least 10000 reviews
SELECT app_name FROM analytics WHERE reviews >= 10000 AND rating < 3;

-- Find the top 10 most-reviewed apps that cost between 10 cents and 1 dollar
SELECT app_name, price, reviews FROM analytics WHERE price BETWEEN 0.10 and 1.00 ORDER BY reviews DESC LIMIT 10;

-- Find the most out of date app
SELECT app_name, last_updated FROM analytics
WHERE last_updated = (
    SELECT MIN(last_updated) FROM analytics
);

-- Find the most expensive app
SELECT app_name, price FROM analytics
WHERE price = (
    SELECT MAX(price) FROM analytics
);

-- Count all the reviews in the Google Play Store
SELECT SUM(reviews) FROM analytics;

-- Find all categories that have more than 300 apps
SELECT category, COUNT(*) FROM analytics
GROUP BY category
HAVING COUNT(*) > 300;

-- Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display name of app along number of reviews, min_installs, and proportion
SELECT app_name, min_installs, reviews, min_installs / reviews AS proportion
FROM analytics
WHERE min_installs >= 100000
ORDER BY proportion DESC
LIMIT 1;