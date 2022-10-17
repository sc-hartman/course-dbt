WITH orders AS (
    SELECT * FROM {{ ref('int_orders') }}
),
orders_products AS(
    SELECT * FROM {{ ref('int_orders_products') }}
)

SELECT  orders.ORDER_GUID
        ,orders.ORDER_CREATED_AT_UTC
        ,orders.USER_GUID
        ,orders.USER_STREET_ADDRESS
        ,orders.USER_ZIPCODE
        ,orders.USER_STATE
        ,orders.USER_COUNTRY
        ,orders.SHIPPING_STREET_ADDRESS
        ,orders.SHIPPING_ZIPCODE
        ,orders.SHIPPING_STATE
        ,orders.SHIPPING_COUNTRY
        ,orders.PROMO_TYPE
        ,orders.PROMO_DISCOUNT
        ,orders.ORDER_COST
        ,orders.SHIPPING_COST
        ,orders.ORDER_TOTAL
        ,orders.TRACKING_GUID
        ,orders.SHIPPING_SERVICE
        ,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC
        ,orders.ESTIMATED_DAYS_FOR_DELIVERY
        ,orders.ORDER_STATUS
        ,orders.ORDER_DELIVERED_AT_UTC
        ,orders.ACTUAL_DAYS_FOR_DELIVERY
        ,COUNT(DISTINCT orders_products.PRODUCT_GUID) AS NUMBER_DISTINCT_PRODUCTS_ORDERED
        ,SUM(orders_products.QUANTITY_ORDERED) AS TOTAL_PRODUCTS_ORDERED
        ,ROUND(AVG(orders_products.PRODUCT_PRICE),2) AS AVG_PRODUCT_PRICE
        ,ROUND(AVG(orders_products.PRODUCT_SUBTOTAL),2) AS AVG_PRODUCT_SUBTOTAL
FROM orders
LEFT JOIN orders_products ON orders.ORDER_GUID = orders_products.ORDER_GUID
GROUP BY    orders.ORDER_GUID
            ,orders.ORDER_CREATED_AT_UTC
            ,orders.USER_GUID
            ,orders.USER_STREET_ADDRESS
            ,orders.USER_ZIPCODE
            ,orders.USER_STATE
            ,orders.USER_COUNTRY
            ,orders.SHIPPING_STREET_ADDRESS
            ,orders.SHIPPING_ZIPCODE
            ,orders.SHIPPING_STATE
            ,orders.SHIPPING_COUNTRY
            ,orders.PROMO_TYPE
            ,orders.PROMO_DISCOUNT
            ,orders.ORDER_COST
            ,orders.SHIPPING_COST
            ,orders.ORDER_TOTAL
            ,orders.TRACKING_GUID
            ,orders.SHIPPING_SERVICE
            ,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC
            ,orders.ESTIMATED_DAYS_FOR_DELIVERY
            ,orders.ORDER_STATUS
            ,orders.ORDER_DELIVERED_AT_UTC
            ,orders.ACTUAL_DAYS_FOR_DELIVERY