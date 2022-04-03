with valid_sessions as (

    select
        session_guid
    from {{ ref('fact_page_views') }}
    where event_type = 'checkout'
)

select
    distinct session_guid

from valid_sessions