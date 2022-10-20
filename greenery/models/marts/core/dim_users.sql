WITH users AS (
    SELECT * FROM {{ ref('int_users') }}
),
orders AS (
    SELECT * FROM {{ ref('int_orders') }}
),
orders_products AS (
    SELECT * FROM {{ ref('int_orders_products') }}
),
user_sessions AS (
    SELECT * FROM {{ ref('int_user_sessions') }}
)

SELECT  users.USER_GUID
        ,users.USER_FIRST_NAME
        ,users.USER_LAST_NAME
        ,users.USER_FULL_NAME
        ,users.USER_EMAIL
        ,users.USER_PHONE_NUMBER
        ,users.USER_CREATED_AT_UTC
        ,users.USER_UPDATED_AT_UTC
        ,users.USER_STREET_ADDRESS
        ,users.USER_ZIPCODE
        ,users.USER_STATE
        ,users.USER_COUNTRY
        ,COUNT(DISTINCT orders.ORDER_GUID) AS ORDERS_PLACED
        ,COUNT(DISTINCT orders_products.PRODUCT_GUID) AS DISTINCT_PRODUCTS_PURCHASED
        ,SUM(orders_products.PRODUCT_SUBTOTAL) AS TOTAL_USER_REVENUE
        ,COUNT(DISTINCT user_sessions.SESSION_GUID) AS DISTINCT_USER_SESSIONS
        ,MIN(user_sessions.SESSION_STARTED_AT_UTC) AS FIRST_SESSION_ACTIVITY
        ,MAX(user_sessions.SESSION_ENDED_AT_UTC) AS LAST_SESSION_ACTIVITY
        ,MIN(user_sessions.SESSION_DURATION_M) AS SHORTEST_SESSION_M
        ,MAX(user_sessions.SESSION_DURATION_M) AS LONGEST_SESSION_M
        ,ROUND(AVG(user_sessions.SESSION_DURATION_M),2) AS AVG_SESSION_DURATION_M
        ,SUM(user_sessions.SESSION_PAGE_VIEWS) AS TOTAL_PAGE_VIEWS
        ,ROUND(TOTAL_PAGE_VIEWS/DISTINCT_USER_SESSIONS,2) AS AVG_PAGE_VIEWS_PER_SESSION
        ,SUM(user_sessions.SESSION_ADD_TO_CARTS) AS TOTAL_ADD_TO_CARTS
        ,SUM(user_sessions.SESSION_CHECKOUTS) AS TOTAL_CHECKOUTS
        ,SUM(user_sessions.SESSION_PACKAGE_SHIPPEDS) AS TOTAL_PACKAGES_SHIPPED
FROM users
LEFT JOIN orders ON users.USER_GUID = orders.USER_GUID
LEFT JOIN orders_products ON orders.ORDER_GUID = orders_products.ORDER_GUID
LEFT JOIN user_sessions ON users.USER_GUID = user_sessions.USER_GUID
GROUP BY    users.USER_GUID
            ,users.USER_FIRST_NAME
            ,users.USER_LAST_NAME
            ,users.USER_FULL_NAME
            ,users.USER_EMAIL
            ,users.USER_PHONE_NUMBER
            ,users.USER_CREATED_AT_UTC
            ,users.USER_UPDATED_AT_UTC
            ,users.USER_STREET_ADDRESS
            ,users.USER_ZIPCODE
            ,users.USER_STATE
            ,users.USER_COUNTRY