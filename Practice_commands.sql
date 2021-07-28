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
