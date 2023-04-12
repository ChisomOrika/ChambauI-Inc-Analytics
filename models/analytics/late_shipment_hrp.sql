{{
  config(
       materialized='view'
  )
}}


WITH hr AS (
    SELECT * FROM {{ ref('highest_review_product') }}
),   ls AS (
    SELECT * FROM {{ ref('late_shipments') }}
)

SELECT SUM(ls.tt_late_shipments) AS late_deliveries
FROM hr
JOIN ls ON ls.id = CAST(hr.product_id AS VARCHAR)