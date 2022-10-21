WITH orders AS (
    SELECT * FROM {{ ref('src_orders') }}
),
users AS (
    SELECT * FROM {{ ref('src_users') }}
),
addresses AS (
    SELECT * FROM {{ ref('src_addresses') }}
),
promos AS (
    SELECT * FROM {{ ref('src_promos') }}
),
events AS (
    SELECT * FROM {{ ref('src_events') }}
)

SELECT  orders.ORDER_GUID
        ,orders.USER_GUID
        ,users.USER_FIRST_NAME||' '||users.USER_LAST_NAME AS USER_FULL_NAME
        ,users.USER_EMAIL
        ,users.USER_PHONE_NUMBER
        ,user_addresses.STREET_ADDRESS AS USER_STREET_ADDRESS
        ,user_addresses.ZIPCODE AS USER_ZIPCODE
        ,user_addresses.STATE AS USER_STATE
        ,user_addresses.COUNTRY AS USER_COUNTRY
        ,promos.PROMO_TYPE
        ,COALESCE(promos.PROMO_DISCOUNT,0) AS PROMO_DISCOUNT
        ,addresses.STREET_ADDRESS AS SHIPPING_STREET_ADDRESS
        ,addresses.ZIPCODE AS SHIPPING_ZIPCODE
        ,addresses.STATE AS SHIPPING_STATE
        ,addresses.COUNTRY AS SHIPPING_COUNTRY
        ,orders.ORDER_CREATED_AT_UTC
        ,orders.ORDER_COST
        ,orders.SHIPPING_COST
        ,orders.ORDER_TOTAL
        ,orders.TRACKING_GUID
        ,orders.SHIPPING_SERVICE
        ,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC
        ,TIMESTAMPDIFF('day',orders.ORDER_CREATED_AT_UTC,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC) AS ESTIMATED_DAYS_FOR_DELIVERY
        ,orders.ORDER_STATUS
        ,orders.ORDER_DELIVERED_AT_UTC
        ,TIMESTAMPDIFF('day',orders.ORDER_CREATED_AT_UTC,orders.ORDER_DELIVERED_AT_UTC) AS ACTUAL_DAYS_FOR_DELIVERY
        ,events.SESSION_GUID
FROM orders
LEFT JOIN users ON orders.USER_GUID = users.USER_GUID
LEFT JOIN addresses ON orders.ADDRESS_GUID = addresses.ADDRESS_GUID
LEFT JOIN addresses AS user_addresses ON users.ADDRESS_GUID = user_addresses.ADDRESS_GUID
LEFT JOIN promos ON orders.PROMO_TYPE = promos.PROMO_TYPE
LEFT JOIN events ON orders.ORDER_GUID = events.ORDER_GUID
GROUP BY    orders.ORDER_GUID
            ,orders.USER_GUID
            ,USER_FULL_NAME
            ,users.USER_EMAIL
            ,users.USER_PHONE_NUMBER
            ,USER_STREET_ADDRESS
            ,USER_ZIPCODE
            ,USER_STATE
            ,USER_COUNTRY
            ,promos.PROMO_TYPE
            ,PROMO_DISCOUNT
            ,SHIPPING_STREET_ADDRESS
            ,SHIPPING_ZIPCODE
            ,SHIPPING_STATE
            ,SHIPPING_COUNTRY
            ,orders.ORDER_CREATED_AT_UTC
            ,orders.ORDER_COST
            ,orders.SHIPPING_COST
            ,orders.ORDER_TOTAL
            ,orders.TRACKING_GUID
            ,orders.SHIPPING_SERVICE
            ,orders.ORDER_ESTIMATED_DELIVERY_AT_UTC
            ,ESTIMATED_DAYS_FOR_DELIVERY
            ,orders.ORDER_STATUS
            ,orders.ORDER_DELIVERED_AT_UTC
            ,ACTUAL_DAYS_FOR_DELIVERY
            ,events.SESSION_GUID