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
