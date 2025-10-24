WITH union_data AS (
	SELECT ad_date, adset_name, COALESCE(impressions, 0) AS impressions
	FROM facebook_ads_basic_daily fabd
	JOIN facebook_adset fa ON fa.adset_id = fabd.adset_id 
	UNION ALL 
	SELECT ad_date, adset_name, COALESCE(impressions, 0) AS impressions
	FROM google_ads_basic_daily
),
filtered_data AS (
SELECT ad_date, adset_name
FROM union_data
WHERE impressions > 0
),
numbered AS (
 SELECT
        adset_name,
        ad_date,
        ROW_NUMBER() OVER (PARTITION BY adset_name ORDER BY ad_date) AS rn
 FROM filtered_data
 ), 
 grouped AS (
 SELECT
        adset_name,
        ad_date,
        rn,
        ad_date - (rn || ' days')::interval AS grp
 FROM numbered
), 
streaks AS (
    SELECT
        adset_name,
        MIN(ad_date) AS start_date,
        MAX(ad_date) AS end_date,
        COUNT(*) AS duration_days
    FROM grouped
    GROUP BY adset_name, grp
  )
  SELECT
    adset_name,
    start_date,
    end_date,
    duration_days
FROM streaks
ORDER BY duration_days DESC
LIMIT 1;