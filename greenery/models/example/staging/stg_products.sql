with products_source as (
    select * from {{ source('postgres', 'products')}}
),

renamed_casted as (
    
    select
        product_id as product_guid,
        name,
        price,
        inventory

    from products_source
)

select * from renamed_casted