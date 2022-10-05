-- CTE to denote which source the staging table is being built from
WITH users AS(
    SELECT * FROM {{ source('src_greenery', 'users') }}
)

SELECT *
FROM users