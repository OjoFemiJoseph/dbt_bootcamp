with source as (

    select * from {{ source('olist', 'product_category') }}

),

renamed as (

    select
        product_category_name,
        product_category_name_english

    from source

)

select * from renamed
