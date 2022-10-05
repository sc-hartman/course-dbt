-- CTE to denote which source the staging table is being built from
WITH orders AS(
    SELECT * FROM {{ source('src_greenery', 'orders') }}
)

SELECT *
FROM orders