{{
  config(
       materialized='table'
  )
}}


WITH late_shipments AS (
  SELECT COUNT(o.order_id) AS tt_late_shipments
  FROM chisorik5367_staging.orders o
  JOIN chisorik5367_staging.shipment_deliveries sd ON o.order_id = sd.order_id
  WHERE CAST(sd.shipment_date AS TIMESTAMP) >= (CAST(o.order_date AS TIMESTAMP) + INTERVAL '6 DAYS')
  AND sd.delivery_date IS NULL
),
undelivered_shipments AS (
  SELECT COUNT(o.order_id) AS tt_undelivered_shipments
  FROM chisorik5367_staging.orders o
  JOIN chisorik5367_staging.shipment_deliveries sd ON o.order_id = sd.order_id
  WHERE sd.delivery_date IS NULL
    AND sd.shipment_date IS NULL
    AND DATE '2022-09-05' >= (CAST(o.order_date AS TIMESTAMP) + INTERVAL '15 DAYS')
)
SELECT 
  CURRENT_DATE AS ingestion_date, 
  ls.tt_late_shipments, 
  us.tt_undelivered_shipments
FROM 
  late_shipments ls, 
  undelivered_shipments us