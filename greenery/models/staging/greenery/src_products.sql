-- CTE to denote which source the staging table is being built from
WITH products AS(
    SELECT * FROM {{ source('src_greenery', 'products') }}
)

SELECT PRODUCT_ID AS PRODUCT_GUID
       ,NAME AS PRODUCT_NAME
       ,PRICE AS PRODUCT_PRICE
       ,INVENTORY AS PRODUCT_INVENTORY
FROM products