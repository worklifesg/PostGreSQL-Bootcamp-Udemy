/* CASE statements */
SELECT
  CASE
    WHEN duration_minutes <= 5 THEN 'less_than_5min'
    WHEN duration_minutes >5
  AND duration_minutes <=10 THEN '5_to_10_minutes'
    WHEN duration_minutes >10 AND duration_minutes <=30 THEN '10_to_30_minutes'
  ELSE
  'greater_than_30min'
END
  AS trip_duration,
  COUNT(*) AS cnt
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
GROUP BY
  trip_duration
  
  
SELECT
  CASE
    WHEN duration_minutes <= 5 THEN 'less_than_5min'
    WHEN duration_minutes >5
  AND duration_minutes <=10 THEN '5_to_10_minutes'
    WHEN duration_minutes >10 AND duration_minutes <=30 THEN '10_to_30_minutes'
  ELSE
  'greater_than_30min'
END
  AS trip_duration,
  COUNT(*) AS cnt
FROM
  `bigquery-public-data.austin_bikeshare.bikeshare_trips`
GROUP BY
  trip_duration

----------------------------------------------------------------------------------------------------------------------------------------

/* SIMPLE ONE CASE STATEMENT  - comes with null if not satisfied*/

SELECT
  CASE
    WHEN LOWER(title) LIKE '%machine learning%' THEN 'machine_learning'
END
  AS topic_desc
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
LIMIT
  100

/* Replace null as Other */

SELECT
  CASE
    WHEN LOWER(title) LIKE '%machine learning%' THEN 'machine_learning'
  ELSE
  'Other'
END
  AS topic_desc
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
LIMIT
  100

SELECT
  CASE
    WHEN LOWER(title) LIKE '%machine learning%' THEN 'machine_learning'
    when lower(title) like '%python%' then 'python'
    when lower(title) like '%big query%' then 'big query'
  ELSE
  'Other'
END
  AS topic_desc
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
LIMIT
  100
  
/* To determine how many posts are there - groupby*/

SELECT
  CASE
    WHEN LOWER(title) LIKE '%machine learning%' THEN 'machine_learning'
    WHEN LOWER(title) LIKE '%python%' THEN 'python'
    WHEN LOWER(title) LIKE '%big query%' THEN 'big query'
  ELSE
  'Other'
END
  AS topic_desc,
  COUNT(*) AS num_topics
FROM
  `bigquery-public-data.stackoverflow.stackoverflow_posts`
GROUP BY
  topic_desc
