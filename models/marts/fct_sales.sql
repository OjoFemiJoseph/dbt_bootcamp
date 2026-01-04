{{ 
  config(
    materialized = 'table'
  ) 
}}

with sales as (

    select *
    from {{ ref('int_order_items_enriched') }}

),

final as (

    select
        order_item_id,
        order_id,
        order_date,

        customer_id,
        customer_name,

        product_id,
        product_name,
        category,

        quantity,
        line_total as revenue

    from sales

)

select *
from final