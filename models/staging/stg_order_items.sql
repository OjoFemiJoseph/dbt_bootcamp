with source as (

    select *
    from {{ source('raw', 'orders_items') }}

),

final as (

    select
        cast(order_item_id as integer) as order_item_id,
        cast(order_id as integer) as order_id,
        cast(product_id as integer) as product_id,
        cast(quantity as integer) as quantity,
        cast(line_total as numeric) as line_total,
        current_date() as date_column
    from source

)

select *
from final