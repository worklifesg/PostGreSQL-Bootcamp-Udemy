 -- ******************* SELECT Statement ******************* --
 
SELECT * FROM actor;
 /* SELECT statement - retrieve information from the table.
  * Use '*' to extract all the columns or entire table
  * Capitalizing statement is only for better reading purpose
  * Semicolon ; in the end for ending the query
  */
SELECT first_name,last_name FROM actor;
  /* Use column names to extract specific columns from thew table  */
SELECT last_name,first_name FROM actor;
  /* Order can be changed by requesting particular column first  */
  
  /* Challenge SELECT 
  * Business situation - send out promotional email to existing customers 
  */
SELECT first_name,last_name,email FROM customer;
  
 -- ******************* SELECT DISTINCT Statement ******************* --
   
SELECT DISTINCT release_year FROM FILM;
/* SELECT DISTINCT - used to return distinct values in a column
* unique values in a column, different release year IN TABLE
*/
SELECT DISTINCT (release_year) FROM FILM;
-- Using paraenthesis is always same as without it --

SELECT DISTINCT (rental_rate) FROM film;
-- How many unique rental rates do we have --

  /* Challenge SELECT DISTINCT
  * Situation - visitor isn't familiar with MPAA movie ratings 
  * we want to know what type of ratings we have in our DB
  * So what ratings do we have available?
  */
SELECT DISTINCT rating FROM film; 
  -- First use SELECT * FROM film to see what column to be used for rating --

 -- ******************* COUNT Statement ******************* --
 
/* COUNT returns the number of input rows that match a specific condition on a query
* so can use any column name or COUNT(*) as the result is always number of rows
* useful when combinded with other statements like DISTINCT
*/
SELECT * FROM PAYMENT;
-- TO know number of rows we can scroll down and see or use COUNT statement --
SELECT COUNT(staff_id) FROM payment;
-- Different types of amount being paid, want to figure actual number of payment (unique) types
SELECT amount FROM payment; -- displays amount column
SELECT DISTINCT amount FROM payment; -- displays the unique values in amount (removing duplicates)
SELECT COUNT(DISTINCT(amount)) FROM payment ;-- display the number of rows of unique values

 -- ******************* SELECT WHERE Statement ******************* --
 
/* In general for writing SQL syntax command, we use SELECT FROM and WHERE as
* SELECT column1,column2
* FROM table
* WHERE conditions
* WHERE statment returns specific conditions on columns for rows to be returned.
* conditions: comparison(=,>,<,>=,<=,<> or !=) and logical(AND,OR,NOT)
*/

SELECT * FROM customer
WHERE first_name='Jared'; -- wants to know whether the lsit has person named Jared

SELECT * FROM film
WHERE rental_rate > 4;-- All rentals rate higher than $4

SELECT * FROM film
WHERE rental_rate > 4 AND replacement_cost>=19.99;
-- All rentals rate higher than $4 adn replacement cost greater than equal to 19.99

SELECT * FROM film
WHERE rental_rate > 4 AND replacement_cost>=19.99 AND rating='R';
-- All rentals rate higher than $4 adn replacement cost greater than equal to 19.99 and ratings with R

-- Now we want all titles only for above criteria
SELECT title FROM film
WHERE rental_rate>4 AND replacement_cost>=19.99 AND rating='R';

-- Now we want to count all titles only for above criteria
SELECT COUNT(title) FROM film
WHERE rental_rate>4 AND replacement_cost>=19.99 AND rating='R';

SELECT COUNT(*) FROM film
WHERE rating='R' OR rating='PG-13';

SELECT * FROM film
WHERE rating!='R';

  /* Challenge 1 SELECT WHERE
  * Situation - Customer forgot their wallet at store. We need to track down their email to inform them
  * What is the email for the customer with the name Nancy Thomas?
  */

SELECT email FROM customer
WHERE first_name='Nancy' AND last_name='Thomas';

  /* Challenge 2 SELECT WHERE
  * Situation - Customer wants to know what movie 'Outlaw Hanky' is about.
  * Could you give them the description for movie 'Outlaw Hanky'
  */
 
SELECT description FROM film
WHERE title='Outlaw Hanky';

  /* Challenge 3 SELECT WHERE
  * Situation - A Customer is late on their movie return, and we have mailed them a 
  * letter to their address at '259 Ipoh Drive'. We should also call them on the phone
  * to let them know. Can you get phone number for customer who lives there?
  */

SELECT phone FROM address
WHERE address='259 Ipoh Drive';

 -- ******************* ORDER BY Statement ******************* --
/* ORDER BY - sorts rows in ascending or descending order and is done at final stage */
SELECT * FROM customer
ORDER BY first_name DESC;

SELECT store_id,first_name,last_name FROM customer
ORDER BY store_id DESC,first_name ASC;
