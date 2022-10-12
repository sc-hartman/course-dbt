-- CTE to denote which source the staging table is being built from
WITH events AS(
    SELECT * FROM {{ source('src_greenery', 'events') }}
)

SELECT EVENT_ID AS EVENT_GUID
       ,SESSION_ID AS SESSION_GUID
       ,USER_ID AS USER_GUID
       ,PAGE_URL
       ,CREATED_AT AS CREATED_AT_UTC
       ,EVENT_TYPE
       ,ORDER_ID AS ORDER_GUID
       ,PRODUCT_ID AS PRODUCT_GUID
FROM events