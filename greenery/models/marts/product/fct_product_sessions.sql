WITH events AS (
    SELECT * FROM {{ ref('src_events') }}
),
products AS (
    SELECT * FROM {{ ref('dim_products') }}
),
order_products AS (
    SELECT * FROM {{ ref('int_orders_products') }}
),
product_checkouts AS (
    SELECT  PRODUCT_GUID
            ,SESSION_GUID
            ,ORDER_GUID
    FROM order_products
            WHERE QUANTITY_ORDERED > 0
)

SELECT  events.PRODUCT_GUID
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,events.SESSION_GUID
        ,events.USER_GUID
        ,MIN(events.CREATED_AT_UTC) AS SESSION_STARTED_AT_UTC
        ,MIN(CASE WHEN events.EVENT_TYPE = 'PAGE_VIEW' THEN events.CREATED_AT_UTC END) AS FIRST_PRODUCT_PAGE_VIEW_UTC
        ,COUNT(DISTINCT CASE WHEN events.EVENT_TYPE = 'PAGE_VIEW' THEN events.EVENT_GUID END) AS SESSION_PAGE_VIEWS
        ,MIN(CASE WHEN events.EVENT_TYPE = 'ADD_TO_CART' THEN events.CREATED_AT_UTC END) AS FIRST_PRODUCT_ADD_TO_CART_UTC
        ,COUNT(DISTINCT CASE WHEN events.EVENT_TYPE = 'ADD_TO_CART' THEN events.EVENT_GUID END) AS SESSION_ADD_TO_CARTS
        -- need to refactor to pull in order/product info for checkouts
        ,MIN(CASE WHEN events.EVENT_TYPE = 'CHECKOUT' AND checkouts.SESSION_GUID IS NOT NULL THEN events.CREATED_AT_UTC END) AS FIRST_CHECKOUT_UTC
        ,COUNT(DISTINCT CASE WHEN events.EVENT_TYPE = 'CHECKOUT' AND checkouts.SESSION_GUID IS NOT NULL THEN events.EVENT_GUID END) AS SESSION_CHECKOUTS
FROM events
JOIN products ON events.PRODUCT_GUID = products.PRODUCT_GUID
LEFT JOIN product_checkouts AS checkouts ON events.ORDER_GUID = checkouts.ORDER_GUID
                                        AND events.SESSION_GUID = checkouts.SESSION_GUID
GROUP BY    events.PRODUCT_GUID
            ,products.PRODUCT_NAME
            ,products.PRODUCT_PRICE
            ,events.SESSION_GUID
            ,events.USER_GUID