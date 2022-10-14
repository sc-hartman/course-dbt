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
- I decided to go for an intermediate layer that focused on joining staging tables together, with some light aggregation where it made sense and leaving the more complex transformations for the marts/prod layer where business logic is likely to be more specific to a particular business vertical. This also avoids pre-aggregation at an early stage and having to deaggregate metrics downstream to slice them by the appropriate dimension(s).

### Tests
#### What assumptions are you making about each model? (i.e. why are you adding each test?)
- For some models, each row needs to have a unique identifier or Primary Key (PK), other columns contain Foreign Keys (FK) and need to have relational integrity with another source, so those relationship tests were implemented. For other columns, we wanted to ensure there were no null values for mandatory fields, only positive values were being entered where it made sense, and certain events (shipping, delivery, etc) could logically only happen after others (order creation).
#### Did you find any "bad" data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- The tests surprisingly did not find any bad data so far. However, I am a heavy user of `IFNULL()` and `COALESCE()` statements to safeguard against `NULL` data already and have learned hard lessons about letting bad data get through to the BI layer.
#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
- I would make sure to automate either the `dbt build` or `dbt test` runs through dbt Cloud or another service, with notifications set up to trigger through email and/or Slack or another messaging service. These notifications would serve as an alert in and of themselves, but I could also conduct an investigation and follow up personally.

### dbt Snapshots
#### Which orders changed from week 1 to week 2?
- The following `ORDER_ID`'s went from _Preparing_ to _Shipped_ status:
  - 914b8929-e04a-40f8-86ee-357f2be3a2a2
  - 05202733-0e17-4726-97c2-0520c024ab85
  - 939767ac-357a-4bec-91f8-a7b25edd46c9