----------------------- Module CONDITIONAL EXPRESSION and PROCEDURE -----------------------------

------ CASE -------
/* only to execute SQL code when certain conditions ar emet. Just like IF/ELSE for other 
programming languages. General and Expression CASE syntax. */

-- check customers that are in first 100 as premium status and 100-200 as Plus status and 
-- others as normal customers (CASE General statement)
SELECT customer_id, 
CASE
	WHEN (customer_id <=100) THEN 'Premium Customer'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus Customer'
	ELSE 'Normal customer'	
END AS customer_class
FROM customer;

-- hold a raffle and going to pick based on customer_id (CASE Expression example)

SELECT customer_id, 
CASE customer_id
	WHEN 2 THEN 'Winner'
	WHEN 5 THEN 'Second Place'
	ELSE 'Normal'	
END AS raffle_results
FROM customer;

-- How many 99 cents films we have (can be done by GROUP BY also)
SELECT rental_rate,
CASE rental_rate 
	WHEN 0.99 THEN 1
	ELSE 0
END
FROM film;

SELECT
SUM (CASE rental_rate 
		WHEN 0.99 THEN 1
		ELSE 0
	 END) AS number_bargains
FROM film; -- 341 films for 0.99 cents

-- Add more columns as well.

SELECT
SUM (CASE rental_rate 
		WHEN 0.99 THEN 1
		ELSE 0
	 END) AS bargains,
SUM (CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
	END) AS regular
FROM film; -- 341 films for 0.99 cents and 323 for 2.99$

SELECT
SUM (CASE rental_rate 
		WHEN 0.99 THEN 1
		ELSE 0
	 END) AS bargains,
SUM (CASE rental_rate
		WHEN 2.99 THEN 1
		ELSE 0
	END) AS regular,
SUM (CASE rental_rate
		WHEN 4.99 THEN 1
		ELSE 0
	END) AS premium
FROM film; -- 341 films for 0.99 cents, 323 for 2.99$ and 336 for 4.99$

/* Challenge Task */

-- Situation 1: Compare various amount of films we habe per movie rating

SELECT
SUM (CASE rating 
		WHEN 'R' THEN 1
		ELSE 0
	 END) AS R_rating,
SUM (CASE rating
		WHEN 'PG' THEN 1
		ELSE 0
	END) AS PG_rating,
SUM (CASE rating
		WHEN 'PG-13' THEN 1
		ELSE 0
	END) AS PG13_Rating
FROM film; -- 195- R, 194- PG, 223-PG13

-------- COALESCE ---------
/* accepts unlimited number of arguments. return 1st argument with the NOT NULL 
and if other arguments has null, it returns NULL.
It is useful, when quering a table that has null value and substitutes it with another value.
*/

-------- CAST ----------

/* convert from one data type to another, In general syntax is - SELECT CAST('5' AS INTEGER)
in postgresql, it is denoted by duble colon. SELECT '5':: INTEGER */

SELECT CAST('5' AS INTEGER) AS new_result; -- cast 5 as int
--SELECT CAST('five' AS INTEGER); -- error as five can't be int

SELECT '5':: INTEGER; -- only in postgresql

-- character length of inventory id?
SELECT * FROM rental;

SELECT CAST(inventory_id AS VARCHAR) FROM rental; -- no longer int as it is VARCHAR
SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) FROM rental; --returns the length of digits as VARCHAR

------- NULLIF ----------
/* takes two inputs and returns NULL if both are equal otherwise it returns the first argument passed */
