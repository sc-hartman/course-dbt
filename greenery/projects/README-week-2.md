[Link to Queries](https://app.snowflake.com/us-east-1/ryb00700/w4hgoGjAcmrw#query)

### Models
#### What is our user repeat rate?
_Repeat Rate = Users who purchased 2 or more times / users who purchased_
- Repeat rate is approximately 79.8%
```sql
SELECT SUM(CASE WHEN ORDERS_PLACED >= 2 THEN 1 ELSE 0 END) / 
        SUM(CASE WHEN ORDERS_PLACED > 0 THEN 1 ELSE 0 END) AS REPEAT_RATE
FROM DEV_DB.DBT_CORY.DIM_USERS
;
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
_NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question._
- I would want to explore correlation between purchases, number of sessions, session length and the price and type of products purchased.

#### Explain the marts models you added. Why did you organize the models in the way you did?
- I decided to go for an intermediate layer that focused on joining staging tables together, with some light aggregation where it made sense and leaving the more complex transformations for the marts/prod layer where business logic is likely to be more specific to a particular business vertical. This also avoids pre-aggregatiion at an early stageand having to deaggregate metrics downstream to slice them by the appropriate dimension(s).

### Tests
#### What assumptions are you making about each model? (i.e. why are you adding each test?)
#### Did you find any "bad" data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
- Placeholder

### dbt Snapshots
#### Which orders changed from week 1 to week 2?
- Placeholder