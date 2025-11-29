with orders as (
    select *
    from {{ ref('stg_orders') }}
),

delivery_metrics as (
    select
        order_id,
        customer_id,
        order_status,
        order_date,
        approved_at,
        carrier_delivery_date,
        customer_delivery_date,
        estimated_delivery_date,
        
        -- Calculate delivery time metrics (in days)
        date_diff(date(approved_at), date(order_date), day) as days_to_approval,
        date_diff(date(carrier_delivery_date), date(approved_at), day) as days_to_carrier,
        date_diff(date(customer_delivery_date), date(carrier_delivery_date), day) as days_in_transit,
        date_diff(date(customer_delivery_date), date(order_date), day) as total_delivery_days,
        
        -- Calculate estimated vs actual
        date_diff(date(estimated_delivery_date), date(order_date), day) as estimated_delivery_days,
        date_diff(date(customer_delivery_date), date(estimated_delivery_date), day) as delivery_delay_days,
        
        -- Delivery status flags
        case 
            when customer_delivery_date is null then false
            when date(customer_delivery_date) <= date(estimated_delivery_date) then true
            else false
        end as is_on_time,
        
        case
            when customer_delivery_date is null then false
            when date(customer_delivery_date) > date(estimated_delivery_date) then true
            else false
        end as is_delayed,
        
        case
            when order_status = 'delivered' and customer_delivery_date is not null then true
            else false
        end as is_delivered,
        
        case
            when order_status = 'canceled' then true
            else false
        end as is_canceled,
        
        -- Delivery performance categories
        case
            when customer_delivery_date is null then 'Not Delivered'
            when date(customer_delivery_date) <= date(estimated_delivery_date) then 'On Time'
            when date_diff(date(customer_delivery_date), date(estimated_delivery_date), day) between 1 and 3 
                then 'Slightly Delayed'
            when date_diff(date(customer_delivery_date), date(estimated_delivery_date), day) between 4 and 7 
                then 'Moderately Delayed'
            when date_diff(date(customer_delivery_date), date(estimated_delivery_date), day) > 7 
                then 'Severely Delayed'
            else 'Unknown'
        end as delivery_performance_category

    from orders
)

select * from delivery_metrics