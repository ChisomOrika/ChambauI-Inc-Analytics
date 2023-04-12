{{
  config(
       materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
), src_deliveries AS (
    SELECT * FROM {{ ref('src_deliveries') }}
)
 
    SELECT COUNT(o.order_id) AS tt_undelivered_shipments
    FROM src_orders o
    JOIN src_deliveries sd ON o.order_id = sd.order_id
    WHERE sd.delivery_date IS NULL
    AND sd.shipment_date IS NULL
    AND DATE '2022-09-05' >= (CAST(o.order_date AS TIMESTAMP) + INTERVAL '15 DAYS')