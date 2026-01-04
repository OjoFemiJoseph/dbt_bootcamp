with source as (

    select *
    from {{ source('raw', 'products') }}

),

final as (

    select
        cast(product_id as integer) as product_id,
        product_name,
        category,
        cast(price as numeric) as price
    from source

)

select *
from final