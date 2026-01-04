with source as (

    select *
    from {{ source('raw', 'loyalty_points') }}

),

final as (

    select
        cast(customer_id as integer) as customer_id,
        cast(points_earned as integer) as points_earned,
        cast(transaction_date as date) as transaction_date,
        source as points_source
    from source

)

select *
from final