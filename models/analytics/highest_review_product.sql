{{
  config(
       materialized='view'
  )
}}

WITH 
    src_products AS (
        SELECT * FROM {{ ref('src_products') }}
    ), 
    src_reviews AS (
        SELECT * FROM {{ ref('src_reviews') }}
    ),
    src_orders AS (
        SELECT * FROM {{ ref('src_orders') }}
    ),
    highest_review_product AS (
        SELECT * FROM (
            SELECT 
                p.product_name, 
                p.product_id, 
                SUM(r.review) AS tt_review_points
            FROM src_reviews r
            JOIN src_products p ON r.product_id = p.product_id
            GROUP BY p.product_name, p.product_id
            ORDER BY tt_review_points DESC
            LIMIT 1
        ) AS h
    ),
  -- CTE to get the review distribution for the highest review product
    review_distribution AS (
        SELECT
            COUNT(r.review) AS total_review,
            COUNT(CASE WHEN r.review = 1 THEN 1 END) AS one_star_count,
            COUNT(CASE WHEN r.review = 2 THEN 1 END) AS two_star_count,
            COUNT(CASE WHEN r.review = 3 THEN 1 END) AS three_star_count,
            COUNT(CASE WHEN r.review = 4 THEN 1 END) AS four_star_count,
            COUNT(CASE WHEN r.review = 5 THEN 1 END) AS five_star_count
        FROM src_reviews r
        JOIN highest_review_product h ON r.product_id = h.product_id
    ),
  -- CTE to get the most ordered date for the highest review product
    most_ordered_day AS (
        SELECT 
            o.order_date AS most_ordered_day, 
            dd.working_day AS not_public_holiday, 
            COUNT(*) AS order_count
        FROM src_orders o
        JOIN highest_review_product h ON o.product_id = CAST(h.product_id AS VARCHAR)
        JOIN {{ ref('src_dates') }} dd ON o.order_date = dd.calendar_dt
        GROUP BY o.order_date, dd.working_day
        ORDER BY order_count DESC
        LIMIT 1
    )

SELECT 
    p.product_name, 
    p.product_id, 
    highest_review_product.tt_review_points,
    review_distribution.total_review, 
    review_distribution.one_star_count, 
    review_distribution.two_star_count, 
    review_distribution.three_star_count, 
    review_distribution.four_star_count, 
    review_distribution.five_star_count,
    most_ordered_day.most_ordered_day,
    most_ordered_day.not_public_holiday,
    most_ordered_day.order_count
FROM highest_review_product
JOIN review_distribution ON true
JOIN most_ordered_day ON true
JOIN src_products p ON highest_review_product.product_id = p.product_id

                        