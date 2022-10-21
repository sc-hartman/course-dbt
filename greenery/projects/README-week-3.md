### Conversion Rate
_NOTE: conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product._
#### What is our overall conversion rate?
- 62.5%
```sql
SELECT SUM(ORDERS_PLACED) /
        SUM(DISTINCT_USER_SESSIONS) AS OVERALL_CONVERSION_RATE
FROM    DEV_DB.DBT_CORY.DIM_USERS;
```
#### What is our conversion rate by product?
```sql
SELECT  PRODUCT_NAME
        ,PRODUCT_CONVERSION_RATE
FROM    DEV_DB.DBT_CORY.DIM_PRODUCTS;
```

### dbt Snapshots
#### Which orders changed from week 2 to week 3?
- The following `ORDER_ID`'s went from `preparing` to `shipped` status:
  - 8385cfcd-2b3f-443a-a676-9756f7eb5404
  - e24985f3-2fb3-456e-a1aa-aaf88f490d70
  - 5741e351-3124-4de7-9dff-01a448e7dfd4