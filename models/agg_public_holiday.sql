{{
  config(
       materialized='table',
       distkey = 'ingestion_date'
  )
}}


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
    if_common.dim_dates dd
JOIN chisorik5367_staging.orders o on dd.calendar_dt=o.order_date
WHERE
    dd.day_of_the_week_num BETWEEN 1 AND 5 AND dd.working_day = false AND o.order_date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
GROUP BY
    ingestion_date
