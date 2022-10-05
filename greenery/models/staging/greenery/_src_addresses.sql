-- CTE to denote which source the staging table is being built from
WITH addresses AS(
    SELECT * FROM {{ source('src_greenery', 'addresses') }}
)

SELECT *
FROM addresses