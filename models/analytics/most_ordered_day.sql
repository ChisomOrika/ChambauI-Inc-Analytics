{{
  config(
       materialized='view'
  )
}}

-- CTE to get the most ordered date for the highest review product
WITH 
    src_orders AS (
     SELECT 
          * 
    FROM 
        {{ ref('src_orders') }}
), 
    highest_review_product AS (
    SELECT
        *
    FROM
      {{ ref('highest_review_product') }}
),
    dd AS (
    SELECT * FROM {{ ref('src_dates') }}
    )


    SELECT o.order_date AS most_ordered_day,dd.working_day as not_public_holiday, COUNT(*) AS order_count
    FROM src_orders o
    JOIN highest_review_product h ON o.product_id = CAST(h.product_id AS VARCHAR)
    JOIN dd on o.order_date=dd.calendar_dt
    GROUP BY o.order_date, dd.working_day
    ORDER BY order_count DESC
    LIMIT 1
                    