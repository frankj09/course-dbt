### What is our overall conversion rate?

```
select
  round(count(distinct case
                          when event_type = 'checkout'
                            then session_guid
                          else null
                        end)::numeric / count(distinct session_guid) * 100, 2) as conversion_rate
  
from dbt_frank_j.fact_page_views
```
Answer: 62.46%