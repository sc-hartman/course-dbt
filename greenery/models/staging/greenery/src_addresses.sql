-- CTE to denote which source the staging table is being built from
WITH addresses AS(
    SELECT * FROM {{ source('src_greenery', 'addresses') }}
)

SELECT ADDRESS_ID AS ADDRESS_GUID
       ,ADDRESS AS STREET_ADDRESS
       ,ZIPCODE
       ,STATE
       ,COUNTRY
FROM addresses