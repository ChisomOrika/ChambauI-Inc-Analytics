WITH raw_dates AS (
    SELECT * FROM {{ source('chambau_dim', 'dates') }}
)
SELECT
    *
FROM
    raw_dates