with product_category_data as (
    select *
    from {{ source('olist', 'product_category')}}
)


select *
from product_category_data