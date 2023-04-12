{{
  config(
       materialized='table',
       distkey = 'ingestion_date'
  )
}}

WITH src_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
), src_dates AS (
    SELECT * FROM {{ ref('src_dates') }}
)
SELECT
    CURRENT_DATE AS ingestion_date,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 1 THEN 1 END)::int AS tt_order_hol_jan,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 2 THEN 1 END)::int AS tt_order_hol_feb,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 3 THEN 1 END)::int AS tt_order_hol_mar,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 4 THEN 1 END)::int AS tt_order_hol_apr,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 5 THEN 1 END)::int AS tt_order_hol_may,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 6 THEN 1 END)::int AS tt_order_hol_jun,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 7 THEN 1 END)::int AS tt_order_hol_jul,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 8 THEN 1 END)::int AS tt_order_hol_aug,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 9 THEN 1 END)::int AS tt_order_hol_sep,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 10 THEN 1 END)::int AS tt_order_hol_oct,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 11 THEN 1 END)::int AS tt_order_hol_nov,
    COUNT(CASE WHEN EXTRACT(MONTH FROM o.order_date) = 12 THEN 1 END)::int AS tt_order_hol_dec
FROM
    src_dates dd
JOIN 
     src_orders o  on dd.calendar_dt=o.order_date
WHERE
    dd.day_of_the_week_num BETWEEN 1 AND 5 AND dd.working_day = false AND o.order_date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
GROUP BY
    ingestion_date
