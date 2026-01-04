{{ 
  config(
    materialized = 'table'
  ) 
}}

with customers as (

    select *
    from {{ ref('stg_customers') }}

),

orders as (

    select *
    from {{ ref('stg_orders') }}

),

loyalty as (

    select *
    from {{ ref('int_customer_loyalty_summary') }}

),

final as (

    select
        c.customer_id,
        c.full_name,
        c.email,
        c.join_date,

        count(distinct o.order_id) as total_orders,
        coalesce(sum(o.total_amount), 0) as lifetime_spend,
        coalesce(l.total_loyalty_points, 0) as total_loyalty_points

    from customers c
    left join orders o
        on c.customer_id = o.customer_id
    left join loyalty l
        on c.customer_id = l.customer_id
    group by
        c.customer_id,
        c.full_name,
        c.email,
        c.join_date,
        l.total_loyalty_points

)

select *
from final