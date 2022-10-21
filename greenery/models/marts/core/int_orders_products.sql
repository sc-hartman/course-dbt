WITH orders AS (
    SELECT * FROM {{ ref('src_orders') }}
),
order_items AS (
    SELECT * FROM {{ ref('src_order_items') }}
),
products AS (
    SELECT * FROM {{ ref('src_products') }}
),
events AS (
    SELECT * FROM {{ ref('src_events') }}
)

SELECT  orders.ORDER_GUID
        ,events.SESSION_GUID
        ,order_items.PRODUCT_GUID
        ,order_items.QUANTITY_ORDERED
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,order_items.QUANTITY_ORDERED * products.PRODUCT_PRICE AS PRODUCT_SUBTOTAL
FROM orders
LEFT JOIN order_items ON orders.ORDER_GUID = order_items.ORDER_GUID
LEFT JOIN products ON order_items.PRODUCT_GUID = products.PRODUCT_GUID
LEFT JOIN events ON orders.ORDER_GUID = events.ORDER_GUID
GROUP BY    orders.ORDER_GUID
            ,events.SESSION_GUID
            ,order_items.PRODUCT_GUID
            ,order_items.QUANTITY_ORDERED
            ,products.PRODUCT_NAME
            ,products.PRODUCT_PRICE
            ,PRODUCT_SUBTOTAL