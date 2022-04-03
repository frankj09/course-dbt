{% snapshot orders_snapshot %}

    {{
        config(
            target_schema = 'snapshots',
            unique_key = 'order_id',

            strategy = 'timestamp',
            updated_at = 'estimated_delivery_at'
        )
    }}

    select *

    from {{ source('postgres', 'orders') }}

{% endsnapshot %}