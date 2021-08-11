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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* WHERE CLAUSE - returning records where certain condition is met - doesn't change the cost of query as it searches across whole table.*/

SELECT
  *
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
WHERE
  state ='FL'
LIMIT
  100
  
/* Multiple clauses */

SELECT
  *
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
WHERE
  state = 'FL'
  AND gender = 'M'
  AND year = 2000
LIMIT
  100

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
  *
FROM
  `bigquery-public-data.usa_names.usa_1910_current`
WHERE
  state = 'FL'
  AND gender = 'M'
  AND year = 2000
ORDER BY
  number DESC

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* WHERE Clause on Numerical Columns */

SELECT
  COUNT(*) AS num_bike_rides
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration = 432
  
/* Num of bike rides who didn't return bikes after 24h */

SELECT
  COUNT(*) AS num_bike_rides
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration >=24*60*60
 
/* Multiple clauses */

SELECT
  COUNT(*) AS num_bike_rides
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration >=1*60*60
  AND tripduration <=2*60*60
  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* OR statement */

SELECT
  COUNT(*) AS num_bike_rides
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  (tripduration >=1*60*60
    AND tripduration <=2*60*60)
  OR (tripduration >=5*60*60
    AND tripduration <=8*60*60)

/* IN statement  - list*/

SELECT
  COUNT(*) AS num_bike_rides
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  tripduration IN (60,
    120)
    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* WHERE Clause on String Columns */

SELECT
  COUNT(*)
FROM
  `bigquery-public-data.london_crime.crime_by_lsoa`
WHERE
  minor_category = 'Harassment'
  
/* Multiple string */

SELECT
  COUNT(*)
FROM
  `bigquery-public-data.london_crime.crime_by_lsoa`
WHERE
  minor_category in ('Harassment','Assault with Injury')

/* Find all categories where minor category keyword is Drugs - It is case senstive 
and percent sign means that we are looking are for any word that has those letters in between*/

SELECT
  DISTINCT minor_category
FROM
  `bigquery-public-data.london_crime.crime_by_lsoa`
WHERE
  minor_category LIKE '%Drugs%'

/* %Drug - end with Drug, Drug% - begin with Drug, %Drug% - anywhere can be Drug */

/* Quiz 3 */

/* 1. How many unique rides involved the bike with a bikeid of 446. */

SELECT
  COUNT(*) AS num_bikeids
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  bikeid = '446'

/* 2. For the bike with bikeid='446', what was the time of its longest ride in minutes? */

SELECT
  duration_minutes
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  bikeid = '446'
ORDER BY
  duration_minutes DESC
LIMIT
  1
  
/* 3. How many bike rides started at the station Zilker Park West. */

SELECT
  COUNT(*) as num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  start_station_name = 'Zilker Park West'

/* 4. How many bike rides started at "Capital Metro HQ - East 5th at Broadway" and ended at "ACC - West & 12th Street" */

SELECT
  COUNT(*) AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  start_station_name = 'Capital Metro HQ - East 5th at Broadway'
  AND end_station_name = 'ACC - West & 12th Street'
  
/* 5. How many bike rides started and ended at the same location?*/

SELECT
  COUNT(*) AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  start_station_name = end_station_name
  
/* 6. How many rides had a trip duration of exactly one hour or less?*/

SELECT
  COUNT(*) AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  duration_minutes <=60

/* 7. How many bike rides had a trip duration between 1 and 2 hours (including both 1 and 2 hour trips)?*/

SELECT
  COUNT(*) AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  duration_minutes <=2*60
  AND duration_minutes >=1*60
  
/* 8. How many bike rides were strictly greater than 3 hours?*/

SELECT
  COUNT(*) AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  duration_minutes >3*60

/* 9. Consider the following two types of bike rides:
          Started at "ACC - West & 12th Street" and ended at "Zilker Park West"
          Started at "Nueces @ 3rd" and ended at "Toomey Rd @ South Lamar"
Of all these types of bike rides, what was the shortest trip duration in minutes?*/

SELECT
  duration_minutes
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  (start_station_name='ACC - West & 12th Street'
    AND end_station_name='Zilker Park West')
  OR (start_station_name='Nueces @ 3rd'
    AND end_station_name='Toomey Rd @ South Lamar')
ORDER BY
  duration_minutes ASC
LIMIT
  1
  
/* 10. The subscriber_type column is a string type column.
        You can see all the different distinct strings in this column from this query:
        
        SELECT
          DISTINCT subscriber_type
         FROM
          `bigquery-public-data.austin_bikeshare.bikeshare_trips`
        
        How many of these distinct strings contain the pattern "B-cycle".*/

SELECT
  DISTINCT subscriber_type
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  subscriber_type LIKE ('%B-cycle%')
  
/* 11. Consider all the bike rides with a subscriber_type that starts with the letter "W". How many bike rides is this?*/

SELECT
  COUNT(*)as num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  subscriber_type LIKE ('W%')
  
  
/* 12. How many bike rides meet the following conditions all together:
        
        - subscriber_type column contains the pattern string "Member"
        - start_station_id is 3792
        - end_station_name is "23rd & Rio Grande"
        - The duration is between 128 and 539 minutes (but not including 128 and 539)*/  

SELECT
  COUNT(*)AS num_bikerides
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
WHERE
  subscriber_type LIKE ('%Member%')
  AND start_station_id = 3792
  AND end_station_name = '23rd & Rio Grande'
  AND duration_minutes > 128
  AND duration_minutes < 539

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* WHERE with TimeStamp Column */

/* Timestamp into Date */
