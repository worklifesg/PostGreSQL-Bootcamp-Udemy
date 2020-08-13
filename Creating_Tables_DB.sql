---------------------- Module: Creating Table and DB -------------------------

/* Before jumping to creating, editing and updating tables, please read Creating_Table_DB.md
file to underatdn the datatypes, primary and foriegn key and constraints on column and 
table */

----- CREATE --------
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY, -- user_id unique so [PK]
	username VARCHAR(50) UNIQUE NOT NULL, -- username is character that must be unique and can't be null
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL, -- unique email of 250 variable character
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP -- can be null as person just created account and has no last login
); -- if you run again, error comes as table is already created

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP 
);

-------- INSERT ---------

SELECT * FROM account; -- no data yet inserted

INSERT INTO account(username,password,email,created_on)
VALUES
('Jose','password','jose@mail.com',CURRENT_TIMESTAMP);

SELECT * FROM account; -- Now new info is added to the account table

INSERT INTO job(job_name)
VALUES
('Astronaut');

SELECT * FROM job; -- 1 entry

INSERT INTO job(job_name)
VALUES
('President');

SELECT * FROM job; -- 2 entry

INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
(1,1,CURRENT_TIMESTAMP);

SELECT * FROM account_job;

INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
(10,10,CURRENT_TIMESTAMP); --error:Key (user_id)=(10) is not present in table "account".
-- Foriegn key constraint


---------- UPDATE -----------
SELECT * FROM account; -- no timestamp for last_login

--change last_login
UPDATE account
SET last_login = CURRENT_TIMESTAMP;

SELECT * FROM account; -- timestamp for last_login updated

UPDATE account
SET last_login=created_on;

SELECT * FROM account; -- timestamp for last_login updated with created_on timestamp

-- change hire dates basedon other table
UPDATE account_job
SET hire_date=account.created_on
FROM account
WHERE account_job.user_id=account.user_id;

SELECT * FROM account_job; 

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on,last_login

--------- DELETE ----------
SELECT * FROM job; -- let's add a new job and then delete it

INSERT INTO job(job_name)
VALUES
('Cowboy')

SELECT * FROM job; -- new job added

DELETE FROM job
WHERE job_name='Cowboy'
RETURNING job_id,job_name -- 3 Cowboy is deleted -- if you run it second time, nothing is there as it is already deleted
 
--------- ALTER ----------

--https://www.postgresql.org/docs/9.1/sql-altertable.html

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
)

ALTER TABLE information
RENAME TO new_info

SELECT * FROM information; -- gives error
SELECT * FROM new_info;

ALTER TABLE new_info
RENAME COLUMN person TO people;

SELECT * FROM new_info; -- person changed to people

INSERT INTO new_info(title)
VALUES
('some new title') -- gives error as people has NOT NULL constraint
-- so either we can specify the value for people or ALTER the constraint for entire column

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;

INSERT INTO new_info(title) -- again try adding title only
VALUES
('some new title') 

SELECT * FROM new_info; -- now people is [null]

---------- DROP -------------

ALTER TABLE new_info
DROP COLUMN people

SELECT * FROM new_info; -- people column is removed

ALTER TABLE new_info
DROP COLUMN people -- error as 'people' column has been removed

ALTER TABLE new_info
DROP COLUMN IF EXISTS people -- gets a notice

---------- CHECK constraint----------------

CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK(birthdate > '1990-01-01'),
	hire_date DATE CHECK(hire_date > birthdate),
	salary INTEGER CHECK(salary>0)
)

INSERT INTO employees(first_name,last_name,birthdate,hire_date,salary)
VALUES
('Jose',
'Portilla',
'1899-11-03',
'2010-01-01',
'100'
) -- error as birthday date constraint is not met

INSERT INTO employees(first_name,last_name,birthdate,hire_date,salary)
VALUES
('Jose',
'Portilla',
'1990-11-03',
'2010-01-01',
'100'
)

INSERT INTO employees(first_name,last_name,birthdate,hire_date,salary)
VALUES
('Sammy',
'Smith',
'1990-11-03',
'2010-01-01',
'-100'
) -- error for salary check constraint of salary > 0

INSERT INTO employees(first_name,last_name,birthdate,hire_date,salary)
VALUES
('Sammy',
'Smith',
'1990-11-03',
'2010-01-01',
'100'
) 

SELECT * FROM employees

-------------------------- Module ends ----------------------------------------
