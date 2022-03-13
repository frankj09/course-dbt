with addresses_source as (
    select * from {{ source('postgres', 'addresses')}}
),

renamed_casted as (
    
    select
        address_id as address_guid,
        address,
        zipcode,
        state,
        country

    from addresses_source
)

select * from renamed_casted