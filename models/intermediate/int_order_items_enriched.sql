{{ 
  config(
    materialized = 'view'
  ) 
}}

with orders as (

    select *
    from {{ ref('stg_orders') }}

),

order_items as (

    select *
    from {{ ref('stg_order_items') }}

),

products as (

    select *
    from {{ ref('stg_products') }}

),

customers as (

    select *
    from {{ ref('stg_customers') }}

),

final as (

    select
        oi.order_item_id,
        o.order_id,
        o.order_date,
        o.customer_id,
        c.full_name as customer_name,

        oi.product_id,
        p.product_name,
        p.category,

        oi.quantity,
        oi.line_total

    from order_items oi
    join orders o
        on oi.order_id = o.order_id
    join products p
        on oi.product_id = p.product_id
    join customers c
        on o.customer_id = c.customer_id

)

select *
from final