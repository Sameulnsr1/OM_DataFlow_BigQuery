WITH constants AS (
  SELECT

  '3253431' AS ACTIVITY,
  '2700447' AS ADVERTISER,
  ['21226183','21225637'] AS CAMP

),



IMP_CLICK AS (
  SELECT
    DATE(TIMESTAMP_SECONDS(CAST((Event_Time/1000000-18000) AS INT64))) AS Date,
    CAST (0 AS INT64) AS Days_Since_Attributed,
    Campaign_ID,
    CAST( Placement_ID AS STRING) AS Placement_ID,
    COUNT(Event_Type) AS Impressions,
    CAST (0 AS INT64) AS Clicks,
    SUM(dbm_media_cost_advertiser_currency)/ 1000000 AS Media_Cost,
    SUM(dbm_total_media_cost_advertiser_currency) / 1000000 AS Total_Media_Cost,
    SUM(Active_View_Measurable_Impressions) AS Measurable_Impressions,
    SUM( Active_View_Viewable_Impressions) AS Viewable_Impressions,
    SUM( Active_View_Eligible_Impressions) AS Eligible_Impressions,
    CAST (0 AS INT64) AS Conversions,
    CAST (0 AS INT64) AS Total_Revenue,
    CAST (0 AS INT64) AS Views
  FROM
    `sn-1992.OM_DCM_4853.p_impression_4853`, constants 
  WHERE
     Campaign_ID IN UNNEST(CAMP)
    AND _PARTITIONTIME >= "2018-06-04 00:00:00" 
    AND _PARTITIONTIME < CURRENT_TIMESTAMP() 
  GROUP BY
    1,
    2,
    3,
    4
  UNION ALL
  SELECT
    DATE(TIMESTAMP_SECONDS(CAST((Event_Time/1000000-18000) AS INT64))) AS Date,
    CAST (0 AS INT64) AS Days_Since_Attributed,
    Campaign_ID,
    Placement_ID,
    CAST (0 AS INT64) AS Impressions,
    COUNT(IFNULL(Event_Type,
        '0')) AS Clicks,
    CAST (0 AS INT64) AS Media_Cost,
    CAST (0 AS INT64) AS Total_Media_Cost,
    CAST (0 AS INT64) AS Active_Impressions,
    CAST (0 AS INT64) AS Measurable_Impressions,
    CAST (0 AS INT64) AS Eligbile_Impressions,
    CAST (0 AS INT64) AS Conversions,
    CAST (0 AS INT64) AS Total_Revenue,
    CAST (0 AS INT64) AS Views
  FROM
    `sn-1992.OM_DCM_4853.p_click_4853`, constants
  WHERE
     Campaign_ID IN UNNEST(CAMP)
    AND _PARTITIONTIME >= "2018-06-04 00:00:00" 
    AND _PARTITIONTIME < CURRENT_TIMESTAMP() 
  GROUP BY
    1,
    2,
    3,
    4 )
SELECT
  *
FROM
  IMP_CLICK
UNION ALL
SELECT
  DATE(TIMESTAMP_SECONDS(CAST((Event_Time/1000000-18000) AS INT64))) AS Date,
  Floor( ((Event_Time - CAST(Interaction_Time AS INT64))/1000000) / 86400 ) as Days_Since_Attributed,
  Campaign_ID,
  Placement_ID,
  CAST (0 AS INT64) AS Impressions,
  CAST (0 AS INT64) AS Clicks,
  CAST (0 AS INT64) AS Media_Cost,
  CAST (0 AS INT64) AS Total_Media_Cost,
  CAST (0 AS INT64) AS Active_Impressions,
  CAST (0 AS INT64) AS Measurable_Impressions,
  CAST (0 AS INT64) AS Eligbile_Impressions,
  COUNT(Event_Type) AS Conversions,
  SUM(Total_Revenue)*1000000 AS Total_Revenue,
  CAST (0 AS INT64) AS Views
FROM
  `sn-1992.OM_DCM_4853.p_activity_4853`, constants 
WHERE
   Campaign_ID IN UNNEST(CAMP)
    AND _PARTITIONTIME >= "2018-06-04 00:00:00" 
    AND _PARTITIONTIME < CURRENT_TIMESTAMP() 
  AND Activity_ID = ACTIVITY
  AND ((Event_Time - CAST(Interaction_Time AS INT64))/1000000) < 2678400
  AND CAST(Conversion_ID AS INT64) IN (1,
    2)
GROUP BY
  1,
  2,
  3,
  4
UNION ALL
SELECT
  DATE(TIMESTAMP_SECONDS(CAST((Event_Time/1000000-18000) AS INT64))) AS Date,
   CAST (0 AS INT64) AS Days_Since_Attributed,
  Campaign_ID,
  Placement_ID,
  CAST (0 AS INT64) AS Impressions,
  CAST (0 AS INT64) AS Clicks,
  CAST (0 AS INT64) AS Media_Cost,
  CAST (0 AS INT64) AS Total_Media_Cost,
  CAST (0 AS INT64) AS Active_Impressions,
  CAST (0 AS INT64) AS Measurable_Impressions,
  CAST (0 AS INT64) AS Eligbile_Impressions,
  CAST (0 AS INT64) AS Conversions,
  CAST (0 AS INT64) AS Total_Revenue,
  COUNT(Rich_Media_Event_Type_ID) AS Views
FROM
  `sn-1992.OM_DCM_4853.p_rich_media_4853`, constants
WHERE
  Rich_Media_Event_ID = '13'
  AND Rich_Media_Event_Type_ID = 3
  AND Advertiser_ID = ADVERTISER
  AND  Campaign_ID IN UNNEST(CAMP)
    AND _PARTITIONTIME >= "2018-06-04 00:00:00" 
    AND _PARTITIONTIME < CURRENT_TIMESTAMP() 
GROUP BY
  1,
  2,
  3,
  4




