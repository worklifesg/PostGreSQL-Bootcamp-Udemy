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
