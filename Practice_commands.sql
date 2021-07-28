------------------------Module:  Practice commands -----------------------------

/* This section cover some concepts that will be used in Google BigQuery for various data science projects */

/* Counting number of records using * or any column name gives same number of total rows */

SELECT
  COUNT(*) as number_of_rows
FROM
  `bigquery-public-data.usa_names.usa_1910_2013`
  
SELECT
  COUNT(gender) as number_of_rows
FROM
  `bigquery-public-data.usa_names.usa_1910_2013`

/* To choose distinct rows corresponding to certain classification like male or female in case gender, number of distinct years, number of states, unique names etc. */

SELECT
  COUNT(DISTINCT gender) as distinct_gender_count,
  COUNT(DISTINCT year) as distinct_year_count,
  COUNT(DISTINCT state) as distinct_state_count,
  COUNT(DISTINCT name) as distinct_name_count
FROM
  `bigquery-public-data.usa_names.usa_1910_2013`
  
/* Counting number of records using * or any column name DOESNOT gives same number of total rows if null is present as particular column count doesn't count rows with NULL values */

SELECT
  COUNT(*) as num_rows, /* Returns all rows with even NULL values */
  COUNT(borough) as borough_count, /* Returns only rows without NULL values */
  COUNT(DISTINCT borough) as disticnt_borough_count, /* Returns distinct boroughs from only rows without NULL values */
  COUNT(contributing_factor_vehicle_1) as contributing_factor_vehicle_1_count, /* Returns only rows without NULL values */
  COUNT(DISTINCT contributing_factor_vehicle_1) as contributing_factor_vehicle_1_unique /* Returns distinct reasons only rows without NULL values */
FROM
  `bigquery-public-data.new_york_mv_collisions.nypd_mv_collisions`
  
/* Quiz 1 

Write SQL queries and check the results in the Big Query Console for each of these questions.

1.How many rows are in the data set bigquery-public-data.new_york.311_service_requests ?
2.In the data set, bigquery-public-data.new_york.311_service_requests , how many total records are there in the agency_name column?
3.In the data set, bigquery-public-data.new_york.311_service_requests , how many distinct agency names are there in the agency_name column? */

SELECT
  COUNT(*) AS num_of_rows,
  COUNT(agency_name) as num_agency_name_records,
  COUNT(DISTINCT agency_name) as distinct_agency_name_records
FROM
  `bigquery-public-data.new_york.311_service_requests`

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* To get distinct list of a certain column (like list of states only) in ascending order */

SELECT
  DISTINCT state
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
ORDER BY
  state ASC /* DESC for descending order */

/* Getting list of last 3 names */

SELECT
  DISTINCT name
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
ORDER BY
  name DESC
LIMIT
  3

/* Quiz 2 */

/* 1. Consider the data set bigquery-public-data.new_york.citibike_trips , and the column tripduration which gives the length of the trip in seconds. Use distinct
tripduration and ORDER BY to find how long the longest ride was in seconds.*/

SELECT
  DISTINCT tripduration
FROM
  `bigquery-public-data.new_york.citibike_trips`
ORDER BY
  tripduration DESC
LIMIT
  3

/* 2. How many distinct birth_year values are there in the bigquery-public-data.new_york.citibike_trips data set?*/

SELECT
  COUNT(DISTINCT birth_year) 
FROM
  `bigquery-public-data.new_york.citibike_trips`

/* 3. Use the DISTINCT and ORDER BY on the table bigquery-public-data.new_york.citibike_trips , to find the smallest (oldest) birth_year.*/

SELECT
  DISTINCT birth_year
FROM
  `bigquery-public-data.new_york.citibike_trips`
ORDER BY
  birth_year ASC
LIMIT
  3

/* 4. Use DISTINCT and ORDERBY to find the largest (most recent) birth_year from the data set bigquery-public-data.new_york.citibike_trips .*/

SELECT
  DISTINCT birth_year
FROM
  `bigquery-public-data.new_york.citibike_trips`
ORDER BY
  birth_year DESC
LIMIT
  3

/* 5. What are all the possible values from the column usertype in the dataset bigquery-public-data.new_york.citibike_trips?*/

SELECT
  DISTINCT usertype 
FROM
  `bigquery-public-data.new_york.citibike_trips`

/* 6. What were the two dates of the most recent and oldest stoptimes in the dataset bigquery-public-data.new_york.citibike_trips ?*/

SELECT
  stoptime
FROM
  `bigquery-public-data.new_york.citibike_trips`
ORDER BY
  stoptime DESC
LIMIT
  1
  
/* 7. What are the distinct values from the column gender in the table bigquery-public-data.new_york.citibike_trips?*/

SELECT
  DISTINCT gender
FROM
  `bigquery-public-data.new_york.citibike_trips`
ORDER BY
  gender ASC

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Distinct records and order for MULTIPLE columns */

SELECT
  DISTINCT borough,
  major_category,
  minor_category
FROM
  `bigquery-public-data.london_crime.crime_by_lsoa`
ORDER BY
  borough,
  major_category,
  minor_category
  
