### dbt Snapshots
#### Which orders changed from week 3 to week 4?
- The following `ORDER_ID`'s went from `preparing` to `shipped` status:
  - 38c516e8-b23a-493a-8a5c-bf7b2b9ea995
  - aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6
  - d1020671-7cdf-493c-b008-c48535415611

### Modeling Challenge
#### How are our users moving through the product funnel?
Users tend to spend a lot of time browsing product pages before eventually adding a product to their cart and then checking out.
#### Which steps in the funnel have the largest drop-off points?
It can vary quite a bit by product, but our overall rates are as such:
- Page View > Add to Cart: 19.2% drop-off
- Add to Cart > Checkout > 18.34% drop-off

You can see an interactive product funnel via the Sigma dashboard located [here](https://app.sigmacomputing.com/corise-dbt/workbook/workbook-5Doo7rCVrzhymeQcTpxGJO).

### Reflection Questions
#### If your organization is using dbt, what are 1-2 things you might do differently/recommend to your organization based on learning from this course?
Our organization already uses most of the best practices that are recommended in this course, with the exception of declaring reference models as CTE's and I understand the reasoning why, so I probably won't make that suggestion. If I had to make any suggestions, it may be leveraging more custom tests and macros to improve/ensure the integrity of our data and models.
#### How would you go about setting up a production/scheduled dbt run of your project in an ideal state?
A lot of what I would do would depend on the orchestrator being used. I do enjoy using dbt Cloud because of the built-in functionality and hosting of the dbt docs, but I can see the advantages of using something like dagster or Airflow. As far as steps involved, I would probably start by pulling in all my seed files, followed by my source/staging tables. Then, I would start building out models using `dbt run`, not `dbt build` as I would not want my run to stop because of a single failed test. I would also run any `operations` on any models that needed them to clean or parse data for analysis/reporting, then I would pass through the `dbt docs generate` command to ensure all docs/dags are up-to-date. Beyond that, any additional commands would highly depend on the operational environment.
