-- CHallenge - Joining on multiple tables
-- Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

-- List the number of films per category.

SELECT *
FROM film_category;

SELECT c.name, COUNT(fc.film_id)
FROM category c
JOIN film_category fc
USING (category_id)
GROUP BY c.name;

-- Retrieve the store ID, city, and country for each store.

SELECT  s.store_id,  c.city, co.country
FROM address a
JOIN city c 
USING (city_id)
JOIN country co
USING (country_id)
JOIN store s
USING (address_id);


-- Calculate the total revenue generated by each store in dollars.

SELECT SUM(p.amount), st.store_id
FROM staff s
JOIN store st
USING (store_id)
JOIN payment p
USING (staff_id)
GROUP BY st.store_id;

-- Determine the average running time of films for each category.

SELECT c.name, AVG(f.length)
FROM film_category fc
JOIN category c
USING (category_id)
JOIN film f
USING (film_id)
GROUP BY c.name;

-- Bonus:

-- Identify the film categories with the longest average running time.

SELECT c.name, AVG(f.length) AS mean_time
FROM film_category fc
JOIN category c
USING (category_id)
JOIN film f
USING (film_id)
GROUP BY c.name
ORDER BY mean_time DESC
LIMIT 3;

-- Display the top 10 most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) as times_rentaled
FROM inventory i
JOIN film f
USING (film_id)
JOIN rental r
USING (inventory_id)
GROUP BY f.title
ORDER BY times_rentaled DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT f.title
FROM film f
JOIN inventory i
USING (film_id)
WHERE i.store_id=1 AND f.title='Academy Dinosaur';

-- Provide a list of all distinct film titles, along with their availability status in the inventory. 
-- Include a column indicating whether each title is 'Available' or 'NOT available.' 
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement 
-- combined with IFNULL."

SELECT DISTINCT(f.title), CASE 
        WHEN i.film_id IS NULL THEN 'Not Available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i -- Así, saldran todos los valores de film, y se podrá comparar con los que no están en "inventory".
USING (film_id);



-- Here are some tips to help you successfully complete the lab:

-- Tip 1: This lab involves joins with multiple tables, which can be challenging. Take your time and follow the steps we discussed in class:

-- Make sure you understand the relationships between the tables in the database. This will help you determine which tables to join and which columns to use in your joins.
-- Identify a common column for both tables to use in the ON section of the join. If there isn't a common column, you may need to add another table with a common column.
-- Decide which table you want to use as the left table (immediately after FROM) and which will be the right table (immediately after JOIN).
-- Determine which table you want to include all records from. This will help you decide which type of JOIN to use. If you want all records from the first table, use a LEFT JOIN. If you want all records from the second table, use a RIGHT JOIN. If you want records from both tables only where there is a match, use an INNER JOIN.
-- Use table aliases to make your queries easier to read and understand. This is especially important when working with multiple tables.
-- Write the query
-- Tip 2: Break down the problem into smaller, more manageable parts. For example, you might start by writing a query to retrieve data from just two tables before adding additional tables to the join. Test your queries as you go, and check the output carefully to make sure it matches what you expect. This process takes time, so be patient and go step by step to build your query incrementally.