# Creating Tables and Databases Theoretical Concepts
These theoretical concepts are helpful in using CREATE, INSERT, DELETE, UPDATE, ALTER, DROP, CHECK constraint functions for making new tables and database.

## Table of Content
  * [Datatypes](#datatypes)
  * [Primary and Foriegn Key](#primary-and-foriegn-key)
  * [Constraints](#constraints)

## Datatypes
  * There are different types of data type that can be assigned different column parameter as per the need of the table. They are as follows:
    * Boolean (True/False)
    * Character (char,varchar,text)
    * Numeric (int, float)
    * Temporal (date, time, timestamp, interval)
    * UUID - Universally Unique Identifiers
    * Array - string and numbers
    * JSON
    * Hstore key-value pair
    * Other data type such as network address and geometric data
  * Example: to store phone number, we can use 'VARCHAR' instead of INTEGER as we don't have to perform any arithmetic operation

## Primary and Foriegn Key
 * Primary Key
   * column or group of columns used to identify a row uniquely in a table (unique, non-null column by default)
   * allow us to easily discern what columns should be used for joining tables.
   * [PK] written column
   * Data type with PK - SERIAL: used to create unique integers
 * Foriegn Key
   * fields or group of fields in a table uniquely iudentifies a row in another table.
   * is defined in a table that REFERENCES to PK of the other table.
   * Multiple keys are possible in fkey
   * Example:
     * payment_id [PK] in payment table and customer_id [pk] in customer table
     * customer_id (fkey) in payment REFERENCES to the PK in customer table

## Constraints
 * Rules enforced on data columns in table to prevent invalid data from being entered into database
 * To ensure accuracy and relability of the data in database
 * Two types of constraints:
   * COLUMN constraints
     * NOT NULL - ensure column can't have null value
     * UNIQUE - ensures all values in the column are different
     * PRIMARY KEY - uniquely identifies each row/record in database
     * FORIEGN KEY - constraints data based on column in other table
     * CHECK - ensures all values in column satifying certain conditions
     * EXCLUSION - ensures if any 2 rows are compared on specified column or expression using specified operator, not all these comparisons will return TRUE
   * TABLE constraints
     * CHECK(condition) - to check a condition when inserting or uploading
     * REFERENCES - to constraintvalue stored in column that must exist in a column in another table
     * UNIQUE(column_list) - forces value stored in column listed inside parentheses to be unique
     * PRIMARY KEY(column_list) - allow to define PK that consists of multiple column
