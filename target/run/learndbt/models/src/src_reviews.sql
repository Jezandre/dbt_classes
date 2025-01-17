
  create or replace   view AIRBNB.DEV.src_reviews
  
   as (
    WITH raw_reviews AS (
 SELECT
 *
 FROM
 AIRBNB.RAW.RAW_REVIEWS
)
SELECT 
    LISTING_ID
    , DATE AS REVIEW_DATE
    , REVIEWER_NAME
    , COMMENTS AS REVIEW_TEXT
    , SENTIMENT AS REVIEW_SENTIMENT

FROM raw_reviews
  );

