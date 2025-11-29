{{
    config(
        tags= "dim",
        group = "sample_group",
        materialized='table'
    )
}}

with agg_customers as (
    
    select *
    from {{ ref('int_olist__customer_orders') }}
)

select 
    customer_id,
    total_orders, 
    total_revenue,
    avg_order_value,
    distinct_products_purchased,
    first_order_date,
    last_order_date,
    is_repeat_customer,
    tenure_days,
    days_since_last_order,
    current_timestamp() as updated_at

from agg_customers
{% if env_var('DBT_ROW_LIMIT', False) %}
    limit {{ env_var('DBT_ROW_LIMIT') }}
{% endif %}
