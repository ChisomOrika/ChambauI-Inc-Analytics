WITH raw_deliveries AS (
    SELECT * FROM {{ source('chambau_facts', 'deliveries') }}
)
SELECT
    *
FROM
    raw_deliveries