with source as (

    select *
    from {{ source('raw', 'customers') }}

),

final as (

    select
        cast(customer_id as integer) as customer_id,
        full_name,
        email,
        cast(join_date as date) as join_date
    from source

)

select *
from final