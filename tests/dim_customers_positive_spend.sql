select *
from {{ ref('dim_customers') }}
where total_orders > 0
  and lifetime_spend <= 0