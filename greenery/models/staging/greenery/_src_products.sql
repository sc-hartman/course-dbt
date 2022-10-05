-- CTE to denote which source the staging table is being built from
WITH products AS(
    SELECT * FROM {{ source('src_greenery', 'products') }}
)

SELECT *
FROM products