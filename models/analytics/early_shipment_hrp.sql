{{
  config(
       materialized='view'
  )
}}


WITH hr AS (
    SELECT * FROM {{ ref('highest_review_product') }}
),   es AS (
    SELECT * FROM {{ ref('early_shipments') }}
)

SELECT SUM(es.tt_early_shipments) AS early_deliveries
FROM hr
JOIN es ON es.id = CAST(hr.product_id AS VARCHAR)
