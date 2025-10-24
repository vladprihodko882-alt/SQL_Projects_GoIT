WITH facebook_data AS (
	SELECT 
		fabd.ad_date
		, 'Facebook' 								AS media_source
		, fc.campaign_name
		, fa.adset_name
		, sum(COALESCE(fabd.spend, 0)) 				AS total_spend
		, sum(COALESCE(fabd.impressions, 0)) 		AS total_impressions
		, sum(COALESCE(fabd.reach, 0))				AS total_reach
		, sum(COALESCE(fabd.clicks, 0)) 		    AS total_clicks
		, sum(COALESCE(fabd.leads, 0))				AS total_leads
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
		, sum(COALESCE(impressions, 0)) 			AS total_impressions
		, sum(COALESCE(reach, 0))					AS total_reach
		, sum(COALESCE(clicks, 0)) 		   			AS total_clicks
		, sum(COALESCE(leads, 0))					AS total_leads
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
	date_trunc('week', ad_date)::date 	AS week_start,
	campaign_name,
	sum(total_value)					AS total_value
FROM combined_data
GROUP BY 1, 2
ORDER BY total_value DESC
LIMIT 1
