with seller_data as (
    select *
    from {{ source('olist', 'sellers')}}
)


select *
from seller_data