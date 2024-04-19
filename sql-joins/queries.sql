-- Join both tables

SELECT * FROM owners o 
FULL OUTER JOIN vehicles v 
ON o.id = v.owner_id;

-- Count number of cars for each owner

SELECT first_name, last_name, COUNT(owner_id)
FROM owners o JOIN vehicles v
ON o.id = v.owner_id
GROUP BY (first_name, last_name)
ORDER BY first_name;

-- Count number of cars for each owner and display average price for each of the cars as integers

SELECT first_name, last_name, ROUND(AVG(price)) AS avg_price, COUNT(owner_id)
FROM owners o JOIN vehicles v
ON o.id = v.owner_id
GROUP BY (first_name, last_name)
HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000
ORDER BY first_name DESC;