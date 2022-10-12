-- CTE to denote which source the staging table is being built from
WITH users AS(
    SELECT * FROM {{ source('src_greenery', 'users') }}
)

SELECT USER_ID AS USER_GUID
       ,FIRST_NAME AS USER_FIRST_NAME
       ,LAST_NAME AS USER_LAST_NAME
       ,EMAIL AS USER_EMAIL
       ,PHONE_NUMBER AS USER_PHONE_NUMBER
       ,CREATED_AT AS USER_CREATED_AT_UTC
       ,UPDATED_AT AS USER_UPDATED_AT_UTC
       ,ADDRESS_ID AS ADDRESS_GUID
FROM users