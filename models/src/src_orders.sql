WITH raw_orders AS (
    SELECT * FROM {{ source('chambau_facts', 'orders') }}
)
SELECT
    *
FROM
    raw_orders