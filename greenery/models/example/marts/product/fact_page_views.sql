with events as (
    select * from {{ ref('stg_events')}}
),

users as (
    select * from {{ ref('stg_users')}}
)

select
    event_guid,
    session_guid,
    users.user_guid,
    page_url,
    events.created_at_utc,
    event_type,
    order_guid,
    product_guid,
    first_name,
    last_name

from events
join users on events.user_guid = users.user_guid