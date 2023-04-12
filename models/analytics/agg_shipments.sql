{{
  config(
       materialized='table'
  )
}}

WITH ls AS (
    SELECT * FROM {{ ref('late_shipments') }}
),  us AS (
    SELECT * FROM {{ ref('undelivered_shipments') }}
)
SELECT 
  CURRENT_DATE AS ingestion_date, 
  sum(ls.tt_late_shipments) as tt_late_shipments , 
  sum(us.tt_undelivered_shipments) as tt_undelivered_shipments
FROM 
   ls, 
   us