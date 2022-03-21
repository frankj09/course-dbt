## (Part 1)

### What is our user repeat rate?

```
-- number of purchases per customer
with purchase_count as (

  select
      user_id,
      count(orders.user_id) as purchases
  
  from orders
  group by 1
),

-- customers who have 2 or more purchases
repeat_customer as (

  select
    user_id,
    count(user_id)
    
  from purchase_count
  where purchases > 1
  group by 1
)

select
  count(repeat_customer.user_id)::float / count(purchase_count.user_id) * 100 as repeat_rate
  
from users
left join purchase_count on purchase_count.user_id = users.user_id
left join repeat_customer on repeat_customer.user_id = users.user_id
```
Answer: 79.839%

### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

I'd want to investigate:
1. A further breakdown repeat rate by the state packages were delivered to, (I don't know about breaking things down by zip but I see that that's another level of granularity we can get to)
2. Do promo's encourage repeat buys (and furthermore if the amount of the discount plays a role)
3. Does the total time of the delivery have an impact
4. What impact does the time spent per event (in the events page) or number of events have?
5. Finally, are the number of items ordered a factor in weather someone comes back in the future or not?

### Explain the marts models you added. Why did you organize the models in the way you did?

For this, I went with the reccomendations given in the homework.

## (Part 2)

### What assumptions are you making about each model?
dim_product:
product_guid is going to be unique and not null (since this is the primary key in the original table, this should hold true)

dim_users:
user_guid is unique and not null (I'm adding address data to the users table, so the assumtion here is that each user has a single address)

fact_orders:
order_guid is unique and order_cost is not null (for order_cost, the assumption is that all orders will have a value. wasn't sure how to implement it so the value has to be > 0, that would be ideal)

user_order_facts:
order_guid is unique and not null and order cost is not null

fact_page_views:
event_guid is unique and not null (each event should be unique)

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
I didn't find any although I only ran two kinds of tests here (I still need to invest time in learning other tests I can do in dbt).

### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
One of the advantages of dbt is that if I make any changes to the data models (which could have a potential of impacting tests), I can test my models before pushing the updates into prod. Aside from that, we'd set tests to run at specific intervals depending on the test to also account for the data itself changing.

In terms of alerting stakeholders, ideally we'd have something like a slack integration for the data team and high level stakeholders to be notified and communicate down as needed.

Self review questions due EOD Sunday: 

Part 1: Were you able to answer the data question asked i.e. What is our user repeat rate? Y/N

Part 1: Were you able to create a marts folder for the three business lines? Y/N

Part 1: Were you able to create at least 1 intermediate model and 1 dimension/fact model within each marts model? Y/N.

Part 2: Were you able to apply dbt tests to your week 1 or week 2 models? Y/N

Reflection: What was most challenging/surprising in completing this week’s project?

Reflection: Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?

Reflection: What are you most proud of about your project?