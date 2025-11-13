with order_item_data as (
    select *
    from {{ source('olist', 'order_items')}}
)


select *
from order_item_data