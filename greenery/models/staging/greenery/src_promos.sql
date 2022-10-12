-- CTE to denote which source the staging table is being built from
WITH promos AS(
    SELECT * FROM {{ source('src_greenery', 'promos') }}
)

SELECT PROMO_ID AS PROMO_TYPE
       ,DISCOUNT AS PROMO_DISCOUNT
       ,STATUS AS PROMO_STATUS
FROM promos