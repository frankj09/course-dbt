with products as (
    select * from {{ ref('stg_products') }}
)

select
    product_guid,
    name,
    price,
    inventory

from products