with product_data as (
    select *
    from {{ source('olist', 'products')}}
)


select *
from product_data