{% test positive_values(model, column_name) %}

    SELECT * 
    FROM {{ model }}
    WHERE {{ column_name }} < 0
      AND {{ column_name }} IS NOT NULL --exclude null values from somehow triggering test

{% endtest %}