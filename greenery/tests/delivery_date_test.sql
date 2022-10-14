--test to ensure the integrity of the order_created_at_utc field
SELECT ORDER_GUID
FROM {{ ref ('fct_orders') }}
    WHERE ORDER_CREATED_AT_UTC > ORDER_ESTIMATED_DELIVERY_AT_UTC
       OR ORDER_CREATED_AT_UTC > ORDER_DELIVERED_AT_UTC