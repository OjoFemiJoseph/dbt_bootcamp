with source as (

    select *
    from {{ source('raw', 'orders') }}

),

final as (

    select
        cast(order_id as integer) as order_id,
        cast(customer_id as integer) as customer_id,
        cast(order_date as date) as order_date,
        cast(total_amount as numeric) as total_amount
    from source

)

select *
from final