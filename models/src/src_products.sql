WITH raw_product AS (
    SELECT * FROM {{ source('chambau_dim', 'products') }}
)
SELECT
    *
FROM
    raw_product