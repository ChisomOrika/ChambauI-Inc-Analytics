{{
  config(
       materialized='view'
  )
}}

-- CTE to get the number of early shipments for all products
WITH src_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
), src_deliveries AS (
    SELECT * FROM {{ ref('src_deliveries') }}
)
    SELECT o.product_id as id,COUNT(o.order_id) AS tt_early_shipments
    FROM src_orders o
    JOIN src_deliveries sd ON o.order_id = sd.order_id
    WHERE CAST(sd.shipment_date AS TIMESTAMP) < (CAST(o.order_date AS TIMESTAMP) + INTERVAL '6 DAYS') AND sd.delivery_date IS NOT NULL
    GROUP BY id
