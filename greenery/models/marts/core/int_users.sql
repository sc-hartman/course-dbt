{{
    config(
        materialized='table'
    )
}}

WITH users AS (
    SELECT * FROM {{ ref ('src_users') }}
),
addresses AS (
    SELECT * FROM {{ ref ('src_addresses') }}
)

SELECT  users.USER_GUID
        ,users.USER_FIRST_NAME
        ,users.USER_LAST_NAME
        ,users.USER_FIRST_NAME||' '||users.USER_LAST_NAME AS USER_FULL_NAME
        ,users.USER_EMAIL
        ,users.USER_PHONE_NUMBER
        ,users.USER_CREATED_AT_UTC
        ,users.USER_UPDATED_AT_UTC
        ,addresses.STREET_ADDRESS AS USER_STREET_ADDRESS
        ,addresses.ZIPCODE AS USER_ZIPCODE
        ,addresses.STATE AS USER_STATE
        ,addresses.COUNTRY AS USER_COUNTRY
FROM users
LEFT JOIN addresses ON users.ADDRESS_GUID = addresses.ADDRESS_GUID