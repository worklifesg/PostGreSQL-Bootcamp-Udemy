------------------------Module:  ADVANCED SQL COMMANDS -----------------------------

/* This section cover advanced SQL commands such as timestamps and EXTRACT, math functions,
string functions, sub-query, self-join */

------- TimeStamps and Extract----------

/* Basically helpful in creating databases where time, date, timestamp, timestamptz is needed. 
Functions like - TIMEZONE, NOW, TIMEOFDAY, CURRENT_TIME, CURRENT_DATE. */

SHOW ALL; -- SHOW - shows the value of the run time parameter, will diusplay the current setting of run-time parameters

SHOW TIMEZONE; -- US/Eastern
SELECT NOW(); -- Current Date and Time like now it is 2020-08-12 12:17:19.39548-04
SELECT TIMEOFDAY(); -- Current Date and Time as a string Wed Aug 12 12:18:55.363360 2020 EDT

SELECT CURRENT_TIME; --12:20:05.332065-04:00
SELECT CURRENT_DATE; -- 2020-08-12

/* EXTRACT()- extract/obtain a sub-component of a date value (YEAR,MONTH,DAY,WEEK,QUARTER)
   AGE()- calculates & returns current age given in a timestamp
   TO_CHAR()- general function to convert data types to text (useful for timestamp formatting)
*/

SELECT EXTRACT(YEAR FROM payment_date) AS myyear
FROM payment; -- get all years

SELECT EXTRACT(MONTH FROM payment_date) as pay_month
FROM payment; -- get all months

SELECT EXTRACT(QUARTER FROM payment_date) as pay_quarter
FROM payment; -- get all quarter
-- check for all other formats: https://www.postgresql.org/docs/8.3/functions-datetime.html


-- How old timestamp was in regards to our current stamp
SELECT AGE(payment_date) 
FROM payment; -- 13 years 5 mons 24 days 01:34:13.003423

-- To convert timestamp to text
SELECT TO_CHAR(payment_date,'HH24:MI:SS')
FROM payment;
SELECT TO_CHAR(payment_date,'mm/dd/YYYY')
FROM payment; -- US Standard
SELECT TO_CHAR(payment_date,'dd/mm/YYYY')
FROM payment; -- EU Standard
-- check for all other formats: https://www.postgresql.org/docs/9.6/functions-formatting.html

/* Challenge Tasks */

-- Situation 1: During which months did payments occur? 
-- Format your answer to return back the full month name

SELECT DISTINCT(TO_CHAR(payment_date,'MONTH')) 
FROM payment; -- March, May, Feburary, April

-- Situation 2: How many payments occured on a Monday
SELECT COUNT(*) FROM payment
WHERE EXTRACT(dow FROM payment_date)=1; -- dow = The day of the week as Sunday(0) to Saturday(6)


-------------------------- Mathematical Functions --------------------------
-- https://www.postgresql.org/docs/current/functions-math.html

-- percentage of rental rate vs replacement cost
SELECT ROUND(rental_rate/replacement_cost,4)*100 AS percent_cost
FROM film;
-- put some 10% of deposit cost
SELECT 0.1*replacement_cost AS deposit
FROM film;


--------------------------- String Functions and Operators ----------------------
--https://www.postgresql.org/docs/current/functions-string.html

SELECT LENGTH(first_name) FROM customer; -- length of first names

SELECT first_name || last_name FROM customer ;-- no space between first and last name
-- Also no column name

SELECT first_name || ' ' || last_name AS Full_Name -- got spacing and column name
FROM customer;

SELECT upper(first_name) || ' ' || upper(last_name) AS Full_Name -- Upper cases
FROM customer;
-- To create email from first name and last name
SELECT lower(left(first_name,1)) || lower(last_name) || '@gmail.com'
AS customer_email
FROM customer;

-- left('',1)-grab first letter from the string

------------------------ Sub-Query -------------------------

/* allow to construct complex queries, essentially performing a query on results of
another query. Can use IN operator along with subquery to check multiple results
EXISTS() - test for existence of rows in a sub-query. */
 
--films that have rental rate higher than avg rental rate
SELECT title,rental_rate FROM film
WHERE rental_rate >
(SELECT AVG(rental_rate) FROM film);
--better to start with a subquery of AVG() and it returns a single value

-- For subquery that return multiple values, it is preferred to use IN operator

--films titles that have been returned between May 29-30, 2005
SELECT film_id,title FROM film
WHERE film_id IN
(SELECT inventory.film_id FROM rental
INNER JOIN inventory
ON inventory.inventory_id=rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30') -- subquery list of film_ids
ORDER BY title;


-- to find out customers who have atleast one payment whose amount is > 11
-- grad first and last name of those customers

SELECT first_name,last_name FROM customer AS c
WHERE EXISTS
(SELECT * FROM payment as p 
 WHERE p.customer_id =c.customer_id
 AND amount > 11);

-- customer below 11
SELECT first_name,last_name FROM customer AS c
WHERE NOT EXISTS
(SELECT * FROM payment as p 
 WHERE p.customer_id =c.customer_id
 AND amount > 11);

--------------------------- SELF JOIN ----------------------
/* q query in whcih a table is joined to itself. comparing values in a column of 
rows within same table
i.e. joining 2 copies of same table * neccesary to use alais for table name else
it would be ambigious */

-- Find all the pairs of films that have same length

SELECT f1.title,f2.title,f1.length
FROM film AS f1
JOIN  film as f2 
ON f1.film_id!=f2.film_id -- if it is = then we match same movie with itself
AND f1.length=f2.length

-----------------------------------Module Ends-------------------------------------
