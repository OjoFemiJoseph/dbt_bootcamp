with order_review_data as (
    select *
    from {{ source('olist', 'order_reviews')}}
)


select *
from order_review_data