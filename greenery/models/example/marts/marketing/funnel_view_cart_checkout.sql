with valid_sessions as (

    select
        session_guid
    from {{ ref('fact_page_views') }}
    where event_type in ('page_view', 'add_to_cart', 'checkout')
)

select
    distinct session_guid

from valid_sessions