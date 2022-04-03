{% macro grant(role) %}

    {% set sql %}

        grant usage on all sequences in schema {{ schema }} to group {{ role }};
        grant select on {{ this }} to group {{ role }};

    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}