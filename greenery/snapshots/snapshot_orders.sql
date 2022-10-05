{% snapshot orders_snapshot %}

{{
    config(
        target_database = 'DEV_DB',
        target_schema = 'DBT_CORY',
        strategy='check',
        unique_key='order_id',
        check_cols=['status']
    )
}}

SELECT *
FROM {{ source('src_greenery','orders') }}

{% endsnapshot %}