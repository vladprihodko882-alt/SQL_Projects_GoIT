# SQL_Projects_GoIT
# Online Advertising Campaigns Analysis (SQL & BigQuery Project)

## Overview
This project was completed as part of the GoIT Data Analytics course.  
It focuses on analyzing online advertising performance from Google Ads and Facebook Ads, as well as event-based data from Google Analytics 4.  
The goal was to calculate key marketing metrics, evaluate campaign efficiency, and prepare datasets for BI visualization.

## Tools & Technologies
- SQL (PostgreSQL)
- BigQuery
- DBeaver
- Google Analytics 4
- Excel

## Project Tasks

### 🧩 Part 1 — SQL Analysis in DBeaver
Analyzed data from `facebook_ads_basic_daily`, `google_ads_basic_daily`, and related tables in the `ads_analysis_goit_course` database.

| File | Description |
|------|--------------|
| `task_1_daily_spend_comparison.sql` | Aggregates daily ad spend (average, min, max) per platform (Google & Facebook). |
| `task_2_top5_romi_days.sql` | Finds top 5 days with the highest combined ROMI across platforms. |
| `task_3_highest_weekly_value_campaign.sql` | Identifies the campaign with the highest weekly total value. |
| `task_4_monthly_reach_growth.sql` | Finds the campaign with the greatest month-over-month reach growth. |
| `task_5_longest_adset_duration.sql` | (Optional) Determines the longest continuous daily adset display period. |

### 📊 Part 2 — Data Preparation in BigQuery
Worked with Google Analytics 4 event data to build conversion-related tables for BI analysis.

| File | Description |
|------|--------------|
| `bigquery_task_1_events_table.sql` | Extracts events, users, and session data for 2021 (filtered by key GA4 events). |
| `bigquery_task_2_conversion_by_channel.sql` | Calculates conversions (visit → cart, checkout, purchase) by source/medium/campaign. |
| `bigquery_task_3_landing_page_comparison.sql` | (Optional) Compares conversion rates between different landing pages for 2020. |

## Key Results
- Delivered fully functional SQL and BigQuery queries ready for execution.
- Created structured datasets for BI tools (Tableau, Looker Studio).
- Gained insights into marketing efficiency, conversions, and campaign performance.
