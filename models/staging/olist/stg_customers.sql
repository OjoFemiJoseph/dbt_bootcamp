
{% set results = run_query('select 1 as id') %}

{% if results is not none %}
  {{ log(results, info=True) }}
{% endif %}

{# Log which command is running #}
{% if flags.WHICH == "run" %}
  {{ log("stg_customers: running via dbt run", info=True) }}
{% elif flags.WHICH == "compile" %}
  {{ log("stg_customers: running via dbt compile", info=True) }}
{% else %}
  {{ log("stg_customers: running via " ~ flags.WHICH, info=True) }}
{% endif %}

with source as (

    select * from {{ source('olist', 'customers') }}

),

renamed as (

    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state

    from source

)

select * from renamed
