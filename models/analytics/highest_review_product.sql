{{
  config(
       materialized='view'
  )
}}

WITH src_products AS (
    SELECT * FROM {{ ref('src_products') }}
), src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)
SELECT p.product_name, p.product_id, SUM(r.review) AS tt_review_points
FROM src_reviews r
JOIN src_products p ON r.product_id = p.product_id
GROUP BY p.product_name, p.product_id
ORDER BY tt_review_points DESC
LIMIT 1
                        