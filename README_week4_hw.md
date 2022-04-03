## Modeling challenge

### How are our users moving through the product funnel?
```
with view_cart_checkout as (

  select
    session_guid
    
  from dbt_frank_j.funnel_view_cart_checkout
),

cart_checkout as (

  select
    session_guid
    
  from dbt_frank_j.funnel_cart_checkout
),

checkout as (

  select
    session_guid
    
  from dbt_frank_j.funnel_checkout
),

current_step as (

  select
    'view_cart_checkout' as current_step,
    count(*) as current_step_count
  from view_cart_checkout
  
  union all
  
  select
    'cart_checkout' as current_step,
    count(*) as current_step_count
  from cart_checkout
  
  union all
  
  select
    'checkout' as current_step,
    count(*) as current_step_count
  from checkout
)

select
  current_step,
  current_step_count,
  round((1.0 - current_step_count::numeric / lag(current_step_count) over ()), 2) drop_off
  
from current_step
```

current_step | current_step_count | drop_off
--- | --- | --- 
view_cart_checkout | 587 | 
cart_checkout | 467 | 0.19
checkout | 361 | 0.23

### Which steps in the funnel have largest drop off points?
The final step, checkout

## Reflection questions (3A)

### if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

We're still in the proof of concept phase at my company, I think the things I'm looking to communicate to help with adoption are:
1. We can codify the ideal data models. So all the extra noise and erroneous data is cleaned before getting to the end user and multiple people building on these data models is possible with dbt
2. We can build in testing and documentation into dbt models
3. It's a great resource for engineers to see what data's being used before making any schema changes as well as show business folk where the underlying data is built off of for reporting via exposures.

### if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

Snapshots and exposures are two things I had no clue about that I think open up some more potential than initially thought. For snapshots specifically, we're pointing at data sources from 3rd parties where we're only seeing current data, so having the ability to create a sudo log table will help us achieve some level of historical data.

### if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

Thinking about how to build tables for an end user is definitly something I've gotten some practice in. I still from time to time forget to through in a key for someone to later be able to join tables together but this has definitly helped. And there' still more improvement to make but getting my feet wet in jinja I think is a force multiplier for me.