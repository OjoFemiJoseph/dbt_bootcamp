with geolocation_data as (
    select *
    from {{ source('olist', 'geolocation')}}
)


select *
from geolocation_data