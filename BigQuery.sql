
# Parsing Strings


SELECT
  Campaign_ID, 
  Placement_ID, 
  Site_ID_DCM, 
  FLOOR(((Event_Time - CAST(Interaction_Time AS INTEGER))/1000000)/86400) AS Days_Since_Attributed,
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  regexp_extract(Other_Data, r'u3=([^;]*)') as Order_ID,
  regexp_extract(Other_Data, r'u4=([^|]*)') as Booking_Value
FROM
  [sn-1992:test_pcln_dcm.p_activity_5199053]
WHERE
	Activity_ID = "3000783"
  AND CAST(Conversion_ID AS INTEGER) IN (1,2)


 #Match Table

SELECT Placement_ID, Placement, COUNT(Placement_ID) as Count 
FROM [sn-1992:test_pcln_dcm.p_match_table_placements_5199053]
GROuP BY 1, 2



#Impressions

SELECT
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  Campaign_ID,
  Placement_ID,
  DBM_Insertion_Order_ID,
  IFNULL(DBM_Line_Item_ID, 1) AS DBM_Line_Item_ID,
  SUM(DBM_Media_Cost_Advertiser_Currency) AS DBM_Media_Cost_Advertiser_Currency,
  SUM(DBM_Total_Media_Cost_Advertiser_Currency) AS DBM_Total_Media_Cost_Advertiser_Currency,
  SUM(DBM_CPM_Fee_1_Advertiser_Currency) AS DBM_CPM_Fee_1_Advertiser_Currency,
  COUNT(Event_Type) AS Impressions
FROM
  [sn-1992:test_pcln_dcm.p_impression_5199053]
WHERE
  Advertiser_ID = '5399022'
GROUP BY
  1,
  2,
  3,
  4,
  5


#Completed Views

SELECT
  DATE(TIMESTAMP(Event_Time / 1000000)) as Date,
  Campaign_ID,
  Placement_ID,
  COUNT(Rich_Media_Event_ID) as Views_ID,
  COUNT(Rich_Media_Event_Type_ID) as Views_Type,
FROM
 [sn-1992:Test_5399022.p_rich_media_5399022]
WHERE
  Rich_Media_Event_ID = '13'
  and
  Rich_Media_Event_Type_ID = 3
GROUP BY
  1,
  2,
  3


#Visits

SELECT
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  Campaign_ID,
  Placement_ID,
  DBM_Insertion_Order_ID,
  COUNT(Event_Type) AS Visit_30D
FROM
  [sn-1992:test_pcln_dcm.p_activity_5199053]
WHERE
  Advertiser_ID = '5399022'
  AND Activity_ID = '3170805'
  AND (Event_Time - CAST(Interaction_Time AS INTEGER))/1000000 < 2592000
  AND CAST(Conversion_ID AS INTEGER) IN (1,
    2)
GROUP BY
  1,
  2,
  3,
  4