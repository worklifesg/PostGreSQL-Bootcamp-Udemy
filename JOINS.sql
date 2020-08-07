----------------- Module: JOINS -------------------------

/* allow us to combine information from multiple tables.
* Alias claue - AS clause - allow to rename a column and functions as well
* INNER, OUTER, LEFT, RIGHT, FULL, UNION JOINS
*/

------ AS clause ------
-- Only used in SELECT statment

SELECT COUNT(amount) AS num_transactions
FROM payment; -- easy to read count of amount as number of transactions instead of just count

--Actually showing how much customers have spent
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id; -- Not clear what sum is, what though process is?

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id; -- sum changed to total_spent; more clearer

-- using HAVING function where mistkae can happen !
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) >100; -- HAVING total_spent > 100 will give error as ALIAS 
-- get assigned at the end at the data output, so not recognized by the system
-- can't be used to filter out

SELECT customer_id,amount AS new_name
FROM payment
WHERE amount > 2 -- same error if we use new_name instead of original column 'amount'

----- JOINS -----

/* INNER JOIN - will result in the set of records that matches both tables (intersection:Venn)
* symmetrical JOIN, by default JOIN is treated as INNER JOIN*/

-- JOIN payment and customer table to get speicifc email of a customer_id for a payment

SELECT * FROM payment
INNER JOIN customer
ON payment.customer_id=customer.customer_id;
-- certain columns from each table
SELECT payment_id,payment.customer_id,first_name FROM payment
INNER JOIN customer
ON payment.customer_id=customer.customer_id;
