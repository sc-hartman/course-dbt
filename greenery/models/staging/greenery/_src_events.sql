-- CTE to denote which source the staging table is being built from
WITH events AS(
    SELECT * FROM {{ source('src_greenery', 'events') }}
)

SELECT *
FROM events