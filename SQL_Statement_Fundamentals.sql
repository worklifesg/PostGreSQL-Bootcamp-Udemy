 --------------------------------- Module 1 Begins --------------------------------------------
 
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

 -- ******************* LIMIT Statement ******************* --
/* LIMIT - limit the number of rows returned for a query
* useful to see table layout and useful with ORDER BY
*/
SELECT * FROM payment
ORDER BY payment_date DESC -- recent payments
LIMIT 10; -- 10 recent payment instead of all payments

SELECT * FROM payment
WHERE amount !=0.00 -- the amount should not be zero
ORDER BY payment_date DESC -- recent payments
LIMIT 10; -- 10 recent payment instead of all payments

  /* Challenge 1 ORDER BY
  * Situation - We want to reward our first 10 paying customers
  * What are the customers ids of the first 10 customers who created a payment
  */
SELECT customer_id FROM payment
ORDER BY payment_date ASC
LIMIT 10;

  /* Challenge 2 ORDER BY
  * Situation - A Customer wants to quickly rent a video to watch over their short lunch break
  * What are the titles of the 5 shortest(in length of runtime) movies?
  */
SELECT title, length FROM film
ORDER BY length ASC -- length is also SQL query word
LIMIT 5;

  /* BONUS Question ORDER BY
  * Situation - IF the previous customer can watch any movie that is 50 minutes or less in
  * run time, how many options does she have
  */
  
SELECT COUNT(title) FROM film
WHERE length<=50; -- Not even needed to ORDER BY

 -- ******************* BETWEEN Statement ******************* --
/* BETWEEN- matches a value against range of values
* value BETWEEN low AND high -- low(>=), high(<=) - 'Inclusive' --
* value NOT BETWEEN low AND high -- low(<), high(>) - 'Exclusive' --
* Date and Timestamp also with BETWEEN and in timestamp starts at 00:00 hours
*/

SELECT * FROM payment
LIMIT 2; -- just to check the contents

SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9; -- amount between 8 and 9

SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 8 AND 9; -- amount between 8 and 9 - no. of transactions

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9; -- amount between 8 and 9 - no. of transactions

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'; 
-- 15 date is not coming because of timestamp, so always use expected date +1 day more

 -- ******************* IN Statement ******************* --
/* IN - to check multiple possible value options, to create a condition that quickly
* checks to see if value if included in the list. 
* Can be integrated with NOT IN to exclude the values in the list
*/

SELECT * FROM payment
LIMIT 2; -- just to check distict values/unique amounts

SELECT DISTINCT(amount) FROM payment
ORDER BY amount; --list of amount in order

-- To see where we have amounts 0.99 1.98 1.99 in payment
SELECT * FROM payment
WHERE amount IN (0.99,1.98,1.99);

--to check how many above payments were there, use COUNT
SELECT COUNT(*) FROM payment
WHERE amount IN (0.99,1.98,1.99); -- example 3301 payments

-- to check how many payments were NOT 0.99,1.98,1.99
SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99,1.98,1.99); -- example 11295 payments

------ to check from string column -------

SELECT * FROM customer
WHERE first_name IN ('John','Jake','Julie');

 -- ******************* LIKE and ILIKE Statement ******************* --
/* to match against a general pattern in a string ex. emails ending with @gmail.com
* LIKE - to perform matching against string data with use of wildcard charcters(%,_)
* LIKE - case sensitive '%A','%a', can combine pattern matching operators '_her%' 
* = Theresa,Cheryl
*/

SELECT * FROM customer -- which people name start with J
WHERE first_name LIKE 'J%';

SELECT COUNT(*) FROM customer -- how many people name start with J
WHERE first_name LIKE 'J%'; -- 65 people

SELECT COUNT(*) FROM customer -- how many people name start with J and end with S
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'; -- 5 people

-- now if I use lower case
SELECT COUNT(*) FROM customer -- how many people name start with j and end with s
WHERE first_name LIKE 'j%' AND last_name LIKE 's%'; -- 0 people

-- Now ILIKE is not case sensitive, then it will give same result of 5 people as before
SELECT COUNT(*) FROM customer -- how many people name start with j and end with s
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%'; -- 5 people

-- Now to check mulitple characters in name like 'er' in the name
SELECT * FROM customer
WHERE first_name LIKE '%er%'; -- 58 people

-- combining pattern matching operators % _
SELECT * FROM customer
WHERE first_name LIKE '_her%'; -- 4 names resulted out

-- Example: first name starts with A, then order the list by last name 

SELECT * FROM customer
WHERE first_name LIKE 'A%'
ORDER BY last_name;

-- Now, we want to remove all people whose last name starts with B

SELECT * FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;

/* General Challenge SELECT WHERE */


-- Situation - How many payment transactions were greater than $5.00?
SELECT COUNT(*) FROM payment
WHERE amount > 5; -- 3168

-- Situation - How many actors have first name that starts with the letter P?
SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';  -- 5 people

-- Situation - How many unique districts are our customers from?
SELECT COUNT(DISTINCT(district)) FROM address; -- 378 districts

-- Situation - Retrieve the list of names of those distict districts from previous question
SELECT DISTINCT(district) FROM address;

-- Situation - How many films have a rating of R and a replacement cost between $5 and $15?
SELECT COUNT(*) FROM film
WHERE rating ='R' AND replacement_cost BETWEEN 5 AND 15; -- 52 films

-- Situation - How many films have the work Trueman somewhere in the title?
SELECT COUNT(*) FROM film
WHERE title LIKE '%Trueman%'; -- 0 films

--------------------------------- Module 1 Ends --------------------------------------------
