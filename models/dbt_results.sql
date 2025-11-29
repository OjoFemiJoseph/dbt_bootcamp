{{
  config(
    materialized = 'incremental',
    unique_key = 'result_id',
    schema='logs'
  )
}}

with empty_table as (
    select
        cast(null as string) as result_id,
        cast(null as string) as invocation_id,
        cast(null as string) as unique_id,
        cast(null as string) as database_name,
        cast(null as string) as schema_name,
        cast(null as string) as name,
        cast(null as string) as resource_type,
        cast(null as string) as status,
        cast(null as float64) as execution_time,
        cast(null as int64) as rows_affected
)

select * from empty_table
where 1 = 0