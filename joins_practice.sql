------------------------- JOINS PRACTICE ----------------------------------

/* LEFT JOIN */

SELECT
  m.year,
  m.country_name AS country,
  m.midyear_population AS population,
  a.country_area AS area
FROM
  `bigquery-public-data.census_bureau_international.midyear_population` m
LEFT JOIN
  `bigquery-public-data.census_bureau_international.country_names_area` a
ON
  m.country_code = a.country_code
WHERE
  m.country_name = "Algeria"
ORDER BY
  year,
  country

/* We can get duplicate records if exists while joining trips, Joining tables with duplicate records */

SELECT
  z.zone_id,
  z.zone_name,
  z.borough,
  t.pickup_datetime,
  t.dropoff_datetime,
  t.pickup_location_id
FROM
  `bigquery-public-data.new_york_taxi_trips.taxi_zone_geom` z
JOIN
  `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2018` t
ON
  z.zone_id = t.pickup_location_id
WHERE
  z.zone_id = '56'
ORDER BY
  t.pickup_location_id ASC

/*  JOINING string columns - using Trimming and Lowering

So when joining tables where columns have strings so they are CASE-senstive while joining them, so it is better to lower or upper case both columns in table 
and also trim them to remove extra spaces if present there

*/

SELECT
  ts.species_common_name,
  ts.form,
  ts.growth_rate,
  ts.fall_color,
  tc.tree_id
FROM
  `bigquery-public-data.new_york_trees.tree_species` ts
JOIN
  `bigquery-public-data.new_york_trees.tree_census_2015` tc
ON
  LOWER(ts.species_common_name) = LOWER(tc.spc_common)
  
  
SELECT
  ts.species_common_name,
  ts.form,
  ts.growth_rate,
  ts.fall_color,
  tc.tree_id
FROM
  `bigquery-public-data.new_york_trees.tree_species` ts
JOIN
  `bigquery-public-data.new_york_trees.tree_census_2015` tc
ON
  TRIM(LOWER(ts.species_common_name)) = TRIM(LOWER(tc.spc_common))

/*  JOIN with WHERE, GROUP BY, ORDER BY, HAVING to see overall SQL statments*/

SELECT
  ts.species_common_name,
  ts.form,
  ts.fall_color,
  tc.status,
  tc.health,
  COUNT(DISTINCT tc.tree_id) AS num_trees,
  AVG(tc.tree_dbh) AS avg_tree_diam,
  MAX(tc.tree_dbh) AS max_tree_diam
FROM
  `bigquery-public-data.new_york_trees.tree_species` ts
JOIN
  `bigquery-public-data.new_york_trees.tree_census_2015` tc
ON
  TRIM(LOWER(ts.species_common_name)) = TRIM(LOWER(tc.spc_common))
WHERE
  tc.health != 'Good'
GROUP BY
  ts.species_common_name,
  ts.form,
  ts.fall_color,
  tc.status,
  tc.health
ORDER BY
  ts.species_common_name,
  ts.form,
  ts.fall_color,
  tc.status,
  tc.health
LIMIT
  1000
  
/* Joining multiple tables */

SELECT
  c.country_name,
  c.country_code,
  c.country_area,
  p.year,
  p.midyear_population AS population,
  b.crude_birth_rate,
  b.crude_death_rate,
  b.net_migration,
  m.life_expectancy,
  m.life_expectancy,
  f.total_fertility_rate
FROM
  `bigquery-public-data.census_bureau_international.country_names_area` c
LEFT JOIN
  `bigquery-public-data.census_bureau_international.midyear_population` p
ON
  c.country_code = p.country_code
LEFT JOIN
  `bigquery-public-data.census_bureau_international.birth_death_growth_rates` b
ON
  p.country_code = b.country_code
  AND p.year = b.year
LEFT JOIN
  `bigquery-public-data.census_bureau_international.mortality_life_expectancy` m
ON
  m.country_name = b.country_code
  AND b.year = m.year
LEFT JOIN
  `bigquery-public-data.census_bureau_international.age_specific_fertility_rates` f
ON
  f.country_code = m.country_code
  AND f.year = m.year
ORDER BY
  c.country_name,
  p.year
