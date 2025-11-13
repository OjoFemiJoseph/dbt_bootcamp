with customer_data as (
    select *
    from {{ source('olist', 'customers')}}
)

select *
from customer_data