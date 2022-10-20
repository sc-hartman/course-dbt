WITH events AS (
    SELECT * FROM {{ ref('src_events') }}
)

SELECT  events.USER_GUID
        ,events.SESSION_GUID
        ,MIN(events.CREATED_AT_UTC) AS SESSION_STARTED_AT_UTC
        ,MAX(events.CREATED_AT_UTC) AS SESSION_ENDED_AT_UTC
        ,TIMESTAMPDIFF('second',SESSION_STARTED_AT_UTC,SESSION_ENDED_AT_UTC) AS SESSION_DURATION_S
        ,ROUND(SESSION_DURATION_S/60.0,2) AS SESSION_DURATION_M
        ,ROUND(SESSION_DURATION_M/60.0,2) AS SESSION_DURATION_H
        -- Create an aggregation column for each event type using dbt_utils macros
        ,{{ dbt_utils.pivot(column='EVENT_TYPE', values=dbt_utils.get_column_values(ref('src_events'), 'EVENT_TYPE'), prefix='SESSION_', suffix='S') }}
        ,COUNT(DISTINCT events.PRODUCT_GUID) AS SESSION_DISTINCT_PRODUCTS
        ,COUNT(DISTINCT events.ORDER_GUID) AS SESSION_DISTINCT_ORDERS
FROM events
GROUP BY    events.USER_GUID
            ,events.SESSION_GUID