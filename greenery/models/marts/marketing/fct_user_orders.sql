{{
    config(
        materialized='table'
    )
}}

WITH users AS (
    SELECT * FROM {{ ref('int_users') }}
),
orders AS (
    SELECT * FROM {{ ref('int_orders') }}
),
orders_products AS(
    SELECT * FROM {{ ref('int_orders_products') }}
)

select 1 as placeholder