{{ 
  config(
    materialized = 'view'
  ) 
}}

with loyalty as (

    select *
    from {{ ref('stg_loyalty_points') }}

),

final as (

    select
        customer_id,
        sum(points_earned) as total_loyalty_points,
        count(*) as loyalty_events
    from loyalty
    group by customer_id

)

select *
from final