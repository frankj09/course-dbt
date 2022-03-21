with orders as (
    select * from {{ ref('stg_orders') }}
),

users as (
    select * from {{ ref('stg_users') }}
),

promos as (
    select * from {{ ref('stg_promos') }}
)

select
    orders.order_guid,
    users.user_guid,
    orders.address_guid,
    orders.created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_guid,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc,
    orders.status,
    first_name,
    last_name,
    email,
    phone_number,
    discount,
    promo_status

from orders
join users on users.user_guid = orders.user_guid
left join promos on promos.promo_id = orders.promo_id