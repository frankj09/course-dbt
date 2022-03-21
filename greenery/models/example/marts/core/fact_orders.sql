with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
)

select
    orders.order_guid,
    user_guid,
    promo_id,
    address_guid,
    product_guid,
    created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_guid,
    shipping_service,
    estimated_delivery_at_utc,
    delivered_at_utc,
    status,
    quantity

from orders
join order_items on orders.order_guid = order_items.order_guid