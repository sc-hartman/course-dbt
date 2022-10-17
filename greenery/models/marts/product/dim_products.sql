WITH products AS (
    SELECT * FROM {{ ref('src_products') }}
),
orders AS (
    SELECT * FROM {{ ref('int_orders_products') }}
)

SELECT  products.PRODUCT_GUID
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,IFNULL(products.PRODUCT_INVENTORY,0) AS CURRENT_PRODUCT_INVENTORY
        ,IFNULL(COUNT(DISTINCT orders.ORDER_GUID),0) AS DISTINCT_ORDERS
        ,IFNULL(SUM(orders.QUANTITY_ORDERED),0) AS QUANTITY_SOLD
        ,IFNULL(SUM(orders.PRODUCT_SUBTOTAL),0) AS PRODUCT_REVENUE
FROM products
LEFT JOIN orders ON products.PRODUCT_GUID = orders.PRODUCT_GUID
GROUP BY    products.PRODUCT_GUID
            ,products.PRODUCT_NAME
            ,products.PRODUCT_PRICE
            ,CURRENT_PRODUCT_INVENTORY