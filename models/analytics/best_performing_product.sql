{{
  config(
       materialized='table'
  )
}}

WITH hr AS (
    SELECT * FROM {{ ref('highest_review_product') }}
), es AS (
    SELECT * FROM {{ ref('early_shipments') }}
), ls AS (
    SELECT * FROM {{ ref('late_shipments') }}
)
SELECT CURRENT_DATE AS ingestion_date, 
       hr.product_name, 
       hr.most_ordered_day, 
       CASE WHEN hr.not_public_holiday IS true THEN false ELSE true END AS is_public_holiday, 
       hr.tt_review_points,
       ROUND (hr.one_star_count / (hr.total_review * 1.0),2) AS pct_one_star_review,
       ROUND (hr.two_star_count / (hr.total_review * 1.0),2) AS pct_two_star_review,
       ROUND (hr.three_star_count / (hr.total_review * 1.0),2) AS pct_three_star_review,
       ROUND (hr.four_star_count / (hr.total_review * 1.0),2) AS pct_four_star_review,
       ROUND (hr.five_star_count / (hr.total_review * 1.0),2) AS pct_five_star_review, 
       ROUND (t1.tt_late_shipments / ((t1.tt_late_shipments + t1.tt_early_shipments) * 1.0),2) as pct_late_shipments,
       ROUND (t1.tt_early_shipments / ((t1.tt_late_shipments + t1.tt_early_shipments) * 1.0),2) as pct_early_shipments
FROM  hr
JOIN 
    (SELECT sum(ls.tt_late_shipments) as tt_late_shipments, 
            sum(es.tt_early_shipments) as tt_early_shipments 
     FROM hr
     JOIN ls ON ls.id = CAST(hr.product_id AS VARCHAR)
     JOIN es ON es.id = CAST(hr.product_id AS VARCHAR)) t1 ON TRUE
