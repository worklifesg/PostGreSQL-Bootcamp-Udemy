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

-- using HAVING function where mistake can happen !
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

-- FULL OUTER JOIN - allow us to specify how to deal with values only present in of the tables
/* being joined. If there is no match, it returns null value for each table respectively.
using WHERE after FULL OUTER JOIN allow us to filter the rows not found in both tables, which
is exact opposite of INNER JOIN */

-- TO check we don't have any customer information related to their payments. Means all payments
-- are attached to the current customer ----- New privacy update

SELECT * FROM  customer
FULL  OUTER JOIN payment
ON customer.customer_id=payment.customer_id -- fully join customer and payment tables
WHERE customer.customer_id IS null -- information about customer that has never made payment
OR payment.payment_id IS NULL; -- payment information associated with any customer
-- filter to find rows either unique to customer table or unique to payment table
-- Result: Null as there is no payment information linked with the customer or any info
-- related to customer that has made any payment.

--TO confirm above privacy update to further validate, but not true in all cases

SELECT COUNT(DISTINCT customer_id) FROM payment; -- 599
SELECT COUNT(DISTINCT customer_id) FROM customer; -- 599

-- LEFT OUTER JOIN -
/* set of records that are in the left table + if there is no  match with right table,
the right table results in null for that non-matched value. WHERE - get rows unique to left table
exclusive to only left table */

-- film - left side - we will see rows just on film table and the one that matches with inventory table
SELECT film.film_id, film.title, inventory_id,store_id
FROM film
LEFT OUTER JOIN inventory ON inventory.film_id=film.film_id
WHERE inventory.film_id IS null; -- to filter the results that are not in inventory

-- RIGHT OUTER JOIN - same as left outer join but here we have values to right table and 
-- matched values with left table.

---------- UNION ------------
/* combine result set of two or more SELECT statements. concatenate or pasting two results together
the idea to use UNION must be logical as results need to be stacked on top of each other.
*/
/* -----------------------Challenge Task-------------------------*/

-- Situtation 1: California sales tax laws have changed and we need to alert our customers
-- to this through email. What are the emails of the customers who live in california?

SELECT address.district,customer.email FROM address
INNER JOIN customer
ON address.address_id=customer.address_id
WHERE address.district = 'California';

-- Situation 2: A customer walks in and is a huge fan of the actor 'Nick Wahlberg' and 
-- wants to know which movies he is in. Get a list of all the movies he has been in?

SELECT title, first_name, last_name FROM film_actor 
INNER JOIN actor 
ON film_actor.actor_id=actor.actor_id
INNER JOIN film
ON film_actor.film_id=film.film_id
WHERE first_name='Nick' AND last_name='Wahlberg';

----------------- Module ends -------------------------
