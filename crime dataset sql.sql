CREATE TABLE "crime_data" (
    DR_NO INT,
    Date_Rptd DATE,
    DATE_OCC DATE,
    TIME_OCC INT,
    AREA INT,
    AREA_NAME VARCHAR(100),
    Rpt_Dist_No INT,
    Part_1_2 INT,
    Crm_Cd INT,
    Crm_Cd_Desc VARCHAR(100),
    Mocodes VARCHAR(100),
    Vict_Age INT,
    Vict_Sex CHAR(1),
    Vict_Descent VARCHAR(10),
    Premis_Cd INT,
    Premis_Desc VARCHAR(100),
    Weapon_Used_Cd INT,
    Weapon_Desc VARCHAR(100),
    Status VARCHAR(10),
    Status_Desc VARCHAR(50),
    Crm_Cd_1 INT,
    Crm_Cd_2 INT,
    Location VARCHAR(100),
    Lat NUMERIC(9,6),
    Lon NUMERIC(9,6)
);

ALTER TABLE crime_data 
ALTER COLUMN vict_sex TYPE VARCHAR(10);


select*
from crime_data
------location with crime description

SELECT area_name AS "Area Name",
       crm_cd_desc AS "Crime Description",
       COUNT(*) AS "Crime Count"
FROM crime_data
GROUP BY area_name, crm_cd_desc
ORDER BY "Crime Count" DESC;

---- which sex committed the crime the most
select vict_sex as gender,crm_cd_desc as "crime code description",count(*) as "crime count"
from crime_data
group by Vict_sex,crm_cd_desc
order by "crime count"desc

------Which premises (Premis_Desc) are most commonly associated with crimes?
select premis_desc as premises,location,crm_cd_desc as "crime code description"
from crime_data
group by premis_desc,location,crm_cd_desc 

------total number of vechicle theft 
SELECT COUNT(*) AS "Number of Vehicle Theft Cases"
FROM crime_data
WHERE crm_cd_desc ILIKE '%vehicle%';

------How does weapon usage (Weapon_Desc) vary by area or crime type?
select *
from crime_data
-------what weapon was used the most
select weapon_desc as weapon,crm_cd_desc,count(*)weapon_count
from crime_data
group by weapon,crm_cd_desc
order by weapon_count desc
------year with the highest crime
select date_rptd as "crime date",crm_cd_desc
from crime_data

SELECT EXTRACT(YEAR FROM date_occ) AS year
FROM crime_data
GROUP BY year
ORDER BY COUNT(*) DESC
LIMIT 1;
------How have specific crime types (e.g., burglary, robbery, assault) trended over time?Useful for seasonal or
----year-over-year changes.
SELECT EXTRACT(YEAR FROM date_occ) AS year,crm_cd_desc AS crime_type,COUNT(*) AS total_crimes
FROM crime_data
WHERE crm_cd_desc ILIKE ANY (ARRAY['%burglary%', '%robbery%', '%assault%'])
GROUP BY year, crime_type
ORDER BY year, crime_type
