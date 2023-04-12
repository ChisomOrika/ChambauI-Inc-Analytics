WITH raw_reviews AS (
    SELECT * FROM {{ source('chambau_facts', 'reviews') }}
)
SELECT
    *
FROM
    raw_reviews