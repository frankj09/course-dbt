with promos_source as (
    select * from {{ source('postgres', 'promos')}}
),

renamed_casted as (
    
    select
        promo_id,
        discount,
        status as promo_status

    from promos_source
)

select * from renamed_casted
