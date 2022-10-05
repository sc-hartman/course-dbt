-- CTE to denote which source the staging table is being built from
WITH promos AS(
    SELECT * FROM {{ source('src_greenery', 'promos') }}
)

SELECT *
FROM promos