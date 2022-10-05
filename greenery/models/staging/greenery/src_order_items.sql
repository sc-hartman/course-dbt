-- CTE to denote which source the staging table is being built from
WITH order_items AS(
    SELECT * FROM {{ source('src_greenery', 'order_items') }}
)

SELECT *
FROM order_items