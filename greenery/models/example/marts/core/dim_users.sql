with users as (
    select * from {{ ref('stg_users') }}
),

addresses as (
    select * from {{ ref('stg_addresses') }}
)

select
    users.user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at_utc,
    updated_at_utc,
    users.address_guid,
    address,
    zipcode,
    state,
    country

from users
join addresses on addresses.address_guid = users.address_guid