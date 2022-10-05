-- CTE to denote which source the staging table is being built from
WITH orders AS(
    SELECT * FROM {{ source('src_greenery', 'orders') }}
)

SELECT ORDER_ID AS ORDER_GUID
       ,USER_ID AS USER_GUID
       ,PROMO_ID
       ,ADDRESS_ID AS ADDRESS_GUID
       ,CREATED_AT AS ORDER_CREATED_AT
       ,ORDER_COST
       ,SHIPPING_COST
       ,ORDER_TOTAL
       ,TRACKING_ID AS TRACKING_GUID
       ,SHIPPING_SERVICE
       ,ESTIMATED_DELIVERY_AT AS ORDER_ESTIMATED_DELIVERY_AT
       ,DELIVERED_AT AS ORDER_DELIVERED_AT
       ,STATUS AS ORDER_STATUS
FROM orders