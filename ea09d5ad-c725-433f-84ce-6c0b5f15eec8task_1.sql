WITH facebook_data AS (
	SELECT 
		fabd.ad_date
		, 'Facebook' 								AS media_source
		, fc.campaign_name
		, fa.adset_name
		, sum(COALESCE(fabd.spend, 0)) 				AS total_spend
		, sum(COALESCE(fabd.value, 0)) 				AS total_value
	FROM facebook_ads_basic_daily fabd
	JOIN facebook_adset fa ON fabd.adset_id = fa.adset_id
	JOIN facebook_campaign fc ON fabd.campaign_id = fc.campaign_id
	GROUP BY ad_date, media_source, campaign_name, adset_name
),
google_data AS (
	SELECT 
		ad_date
		, 'Google' 									AS media_source
		, campaign_name
		, adset_name
		, sum(COALESCE(spend, 0)) 					AS total_spend
		, sum(COALESCE(value, 0)) 					AS total_value
	FROM google_ads_basic_daily
	GROUP BY ad_date, media_source, campaign_name, adset_name
	),
combined_data AS (
	SELECT * FROM facebook_data
	UNION ALL 
	SELECT * FROM google_data
)
SELECT 
	ad_date,
	CASE 
        WHEN SUM(total_spend) = 0 THEN 0
  		ELSE ROUND(((SUM(total_value) - SUM(total_spend)) / SUM(total_spend)) * 100, 2)
    END AS romi
FROM combined_data
GROUP BY ad_date
ORDER BY 2 DESC 
LIMIT 5