----------------------- Module: GROUP BY Statements ----------------------------

-- Aggrgate Data and apply functions to better understand how data is distributed
/* Aggregate functions - take multiple inputs and returns a single output
* Common functions - AVG(),COUNT(),MAX(),MIN(),SUM() - AVG()-returns a floating value and 
* ROUND() can be used to round the decimals value */

SELECT * FROM film;

-- find minimum value of replcaement cost from film table 9.99$
SELECT MIN(replacement_cost) FROM film; 

-- find most expensive replacement cost for the film 29.99$
SELECT MAX(replacement_cost) FROM film; 

-- Find both max and min together
SELECT MAX(replacement_cost), MIN(replacement_cost)
FROM film;

-- average replacement cost
SELECT AVG(replacement_cost) FROM film; --19.9840000000000000

--Wrapping up average value - ROUND () uses paranthesis where AVG() function comes
SELECT ROUND(AVG(replacement_cost),2) FROM film;

-- How much we need to replace all movies?
SELECT SUM(replacement_cost) FROM film;

-------------------- GROUP BY - I ----------------------

/* 3 steps - Category column with data values, split each category and then generates 
* single value for each category using GROUP BY function (AGG())
* Never use WHERE to filter variables that are used in AGG().
*/

SELECT * FROM payment; -- customer_id,staff_id - categorical

SELECT customer_id FROM payment
GROUP BY customer_id -- list of distinct customer_id
ORDER BY customer_id;

-- Apply aggregate function - ex. which customer is spedning most money
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id -- total sum of amount PER customer id (reading wise)
ORDER BY SUM(amount) DESC;

-- Count number of transactions
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

-- It is to better to choose SELECT order as same as GROUP BY to keep information simple

-- GROUP BY on date column - with timestamp, first convert it to standard format and then perfom GROUP BY
SELECT DATE(payment_date),SUM(amount) FROM payment -- removes timestamp information
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

--------GROUP BY Challenge Tasks------------

-- Situation - We have two staff members, with staff ids 1 and 2. We want to give a bonus
-- to the staff member that handles most payments. How many payments did each staff member handle and who gets the bonus?

SELECT staff_id,COUNT(amount) FROM payment
GROUP BY staff_id
ORDER BY COUNT(amount) DESC; -- staff_id 2 gets bonus

-- Situation - Corporate HQ is conducting a study on the relationship between
-- replacement cost and movie MPAA rating. What is the average replacement cost per MPAA rating?

SELECT rating, ROUND(AVG(replacement_cost),3) 
FROM film
GROUP BY rating;

-- Situation - We are running a promotion to reward our top 5 customers with coupons
-- What are the customer ids of the top 5 customers by total spend?

SELECT customer_id,SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

----------------------- HAVING Statement ----------------------
/* Allows us to filter after AGG() has taken place */

SELECT customer_id, SUM(amount) FROM payment
WHERE customer_id NOT IN (184,87,477) -- filter these customer id from the list
GROUP BY customer_id;

SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount)>100
ORDER BY SUM(amount);

-- to use HAVING with COUNT -- ex number of customers per store
SELECT store_id,COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT(*)>300; -- store with more than 300 customers

--------HAVING Challenge Tasks------------

-- Situation - We are launching a platinum service for most loyal customers. 
-- We will assign platinum status to customers that have had 40 or more transaction payments
-- What customer_ids are eligible for platinum status?

SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >=40; -- only 3 customers were filtered out

-- Situation - What are the customers ids of customers who have spent more than $100 payments
-- transactions with our staff_id member 2?

SELECT customer_id, staff_id, SUM(amount) FROM payment
WHERE staff_id=2
GROUP BY customer_id,staff_id
HAVING SUM(amount)>100

----------------------- Module ends ----------------------------
