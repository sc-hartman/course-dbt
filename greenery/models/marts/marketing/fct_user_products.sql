{{
    config(
        materialized='table'
    )
}}

WITH orders AS (
    SELECT * FROM {{ ref('int_orders') }}
),
orders_products AS(
    SELECT * FROM {{ ref('int_orders_products') }}
)

SELECT  orders.USER_GUID
        ,orders.USER_FULL_NAME
        ,orders.USER_EMAIL
        ,orders.USER_STREET_ADDRESS
        ,orders.USER_ZIPCODE
        ,orders.USER_STATE
        ,orders.USER_COUNTRY
        ,orders.ORDER_GUID
        ,orders.ORDER_CREATED_AT_UTC
        ,orders_products.PRODUCT_GUID
        ,orders_products.QUANTITY_ORDERED
        ,orders_products.PRODUCT_NAME
        ,orders_products.PRODUCT_PRICE
        ,orders_products.PRODUCT_SUBTOTAL
FROM orders
LEFT JOIN orders_products ON orders.ORDER_GUID = orders_products.ORDER_GUID