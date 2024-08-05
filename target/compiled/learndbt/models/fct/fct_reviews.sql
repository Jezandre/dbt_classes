

WITH  __dbt__cte__src_reviews as (
WITH raw_reviews AS (
 SELECT
 *
 FROM
 AIRBNB.raw.raw_reviews
)
SELECT 
    LISTING_ID
    , DATE AS REVIEW_DATE
    , REVIEWER_NAME
    , COMMENTS AS REVIEW_TEXT
    , SENTIMENT AS REVIEW_SENTIMENT

FROM raw_reviews
), src_reviews AS (
 SELECT * FROM __dbt__cte__src_reviews
)
SELECT 
md5(cast(coalesce(cast(listing_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(reviewer_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(review_text as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as review_id,
* FROM src_reviews
WHERE REVIEW_TEXT is not null

 AND review_date > (select max(review_date) from AIRBNB.DEV.fct_reviews)
