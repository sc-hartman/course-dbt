WITH events AS (
    SELECT * FROM {{ ref('src_events') }}
),
products AS (
    SELECT * FROM {{ ref('dim_products') }}
),
order_products AS (
    SELECT * FROM {{ ref('int_orders_products') }}
),
event_order_bridge AS (
    SELECT  SESSION_GUID
            ,EVENT_GUID
            ,ORDER_GUID
            ,EVENT_TYPE
    FROM events
            WHERE ORDER_GUID IS NOT NULL
),
product_events AS (
    SELECT  PRODUCT_GUID
            ,SESSION_GUID
            ,EVENT_GUID
            ,USER_GUID
            ,CREATED_AT_UTC
            ,EVENT_TYPE
    FROM events
        WHERE PRODUCT_GUID IS NOT NULL
),
product_checkouts AS (
    SELECT  op.PRODUCT_GUID
            ,op.SESSION_GUID
            ,brdg.EVENT_GUID
            ,op.USER_GUID
            ,op.ORDER_CREATED_AT_UTC AS CREATED_AT_UTC
            ,'CHECKOUT' AS EVENT_TYPE
    FROM order_products AS op
    LEFT JOIN event_order_bridge AS brdg ON op.SESSION_GUID = brdg.SESSION_GUID
                                        AND op.ORDER_GUID = brdg.ORDER_GUID
            WHERE op.QUANTITY_ORDERED > 0
              AND brdg.EVENT_TYPE = 'CHECKOUT'
),
product_events_combined AS (
    SELECT * FROM product_events
    UNION ALL
    SELECT * FROM product_checkouts
),
session_started AS (
    SELECT  SESSION_GUID
            ,MIN(CREATED_AT_UTC) AS SESSION_STARTED_AT_UTC
    FROM    events
    GROUP BY SESSION_GUID
)

SELECT  pr_events.PRODUCT_GUID
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,pr_events.SESSION_GUID
        ,pr_events.USER_GUID
        ,ss.SESSION_STARTED_AT_UTC
        ,pr_events.EVENT_TYPE
        ,pr_events.CREATED_AT_UTC AS EVENT_TIME_UTC
FROM product_events_combined AS pr_events
JOIN products ON pr_events.PRODUCT_GUID = products.PRODUCT_GUID
LEFT JOIN session_started AS ss ON pr_events.SESSION_GUID = ss.SESSION_GUID
ORDER BY    pr_events.SESSION_GUID
            ,pr_events.PRODUCT_GUID
            ,pr_events.CREATED_AT_UTC ASC
            ,ss.SESSION_STARTED_AT_UTC ASC