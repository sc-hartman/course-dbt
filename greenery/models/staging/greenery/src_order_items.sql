-- CTE to denote which source the staging table is being built from
WITH order_items AS(
    SELECT * FROM {{ source('src_greenery', 'order_items') }}
)

SELECT ORDER_ID AS ORDER_GUID
       ,PRODUCT_ID AS PRODUCT_GUID
       ,QUANTITY AS QUANTITY_ORDERED
FROM order_items