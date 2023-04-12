{{
  config(
       materialized='view'
  )
}}

-- CTE to get the review distribution for the highest review product
WITH 
    src_reviews AS (
     SELECT 
          * 
    FROM 
        {{ ref('src_reviews') }}
), 
    highest_review_product AS (
    SELECT
        *
    FROM
      {{ ref('highest_review_product') }}
)

    SELECT
    COUNT(r.review) AS total_review,
    COUNT(CASE WHEN r.review = 1 THEN 1 END) AS one_star_count,
    COUNT(CASE WHEN r.review = 2 THEN 1 END) AS two_star_count,
    COUNT(CASE WHEN r.review = 3 THEN 1 END) AS three_star_count,
    COUNT(CASE WHEN r.review = 4 THEN 1 END) AS four_star_count,
    COUNT(CASE WHEN r.review = 5 THEN 1 END) AS five_star_count
FROM src_reviews r
JOIN highest_review_product h ON r.product_id = h.product_id