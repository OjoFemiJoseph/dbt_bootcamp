with order_payment_data as (
    select *
    from {{ source('olist', 'order_payments')}}
)


select *
from order_payment_data