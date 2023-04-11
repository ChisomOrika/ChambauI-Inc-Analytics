{{
  config(
       materialized='table'
  )
}}

-- CTE to get the product with the highest total review points
WITH highest_review_product 
                        AS (
                            SELECT p.product_name, p.product_id, SUM(r.review) AS tt_review_points
                            FROM chisorik5367_staging.reviews r
                            JOIN if_common.dim_products p ON r.product_id = p.product_id
                            GROUP BY p.product_name, p.product_id
                            ORDER BY tt_review_points DESC
                            LIMIT 1
                          ),
-- CTE to get the most ordered date for the highest review product
most_ordered_date 
                AS (
                    SELECT o.order_date AS most_ordered_day, COUNT(*) AS order_count
                    FROM chisorik5367_staging.orders o
                    JOIN highest_review_product h ON o.product_id = CAST(h.product_id AS VARCHAR)
                    GROUP BY o.order_date
                    ORDER BY order_count DESC
                    LIMIT 1
                    ),
-- CTE to get the review distribution for the highest review product
review_distribution
                  AS (
                    SELECT
                        COUNT(r.review) AS total_review,
                        COUNT(CASE WHEN r.review = 1 THEN 1 END) AS one_star_count,
                        COUNT(CASE WHEN r.review = 2 THEN 1 END) AS two_star_count,
                        COUNT(CASE WHEN r.review = 3 THEN 1 END) AS three_star_count,
                        COUNT(CASE WHEN r.review = 4 THEN 1 END) AS four_star_count,
                        COUNT(CASE WHEN r.review = 5 THEN 1 END) AS five_star_count
                    FROM chisorik5367_staging.reviews r
                    JOIN highest_review_product h ON r.product_id = h.product_id
                     ),
-- CTE to get the number of late shipments for the highest review product
late_shipments 
             AS (
                SELECT COUNT(*) AS late_deliveries
                FROM chisorik5367_staging.orders o
                JOIN chisorik5367_staging.shipment_deliveries sd ON o.order_id = sd.order_id
                JOIN highest_review_product h ON o.product_id = CAST(h.product_id AS VARCHAR)
                WHERE CAST(sd.shipment_date AS timestamp) >= (CAST(o.order_date AS timestamp) + interval '6 days') AND sd.delivery_date IS NULL
                ),
-- CTE to get the number of early shipments for the highest review product
early_shipments 
             AS (
                SELECT COUNT(*) AS early_deliveries
                FROM chisorik5367_staging.orders o
                JOIN chisorik5367_staging.shipment_deliveries sd ON o.order_id = sd.order_id
                JOIN highest_review_product h ON o.product_id = CAST(h.product_id AS VARCHAR)
                WHERE CAST(sd.shipment_date AS timestamp) < (CAST(o.order_date AS timestamp) + interval '6 days') AND sd.delivery_date IS NOT NULL
                )
-- Final Result
SELECT CURRENT_DATE AS ingestion_date, 
       hr.product_name, 
       mods.most_ordered_day, 
       CASE WHEN dd.working_day IS true THEN false ELSE true END AS is_public_holiday, 
	   hr.tt_review_points,
       ROUND (rd.one_star_count / (rd.total_review * 1.0),2) AS pct_one_star_review,
       ROUND (rd.two_star_count / (rd.total_review * 1.0),2) AS pct_two_star_review,
       ROUND (rd.three_star_count / (rd.total_review * 1.0),2) AS pct_three_star_review,
       ROUND (rd.four_star_count / (rd.total_review * 1.0),2) AS pct_four_star_review,
       ROUND (rd.five_star_count / (rd.total_review * 1.0),2) AS pct_five_star_review, 
       ROUND (ls.late_deliveries / ((ls.late_deliveries + es.early_deliveries) * 1.0),2) as pct_late_shipments,
       ROUND (es.early_deliveries / ((ls.late_deliveries + es.early_deliveries) * 1.0),2) as pct_early_shipments
FROM highest_review_product hr
JOIN most_ordered_date mods ON true
JOIN if_common.dim_dates dd on dd.calendar_dt=mods.most_ordered_day
JOIN review_distribution rd ON true
JOIN late_shipments ls ON TRUE
JOIN early_shipments es ON TRUE