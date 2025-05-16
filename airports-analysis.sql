/*
Airports Exercise
 
Data source: https://ourairports.com/data/
Data dictionary: https://ourairports.com/help/data-dictionary.html
 
In this exercise we analyse the countries, airports and airports_frequencies table
These have  matching columns:
* airports.ident matches airport_frequencies.airport_ident
* countries.code matches airports.iso_country
*/

--Top 10 is chosen at random as there is no order by
 
-- Show 10 sample rows of the airports table
SELECT  TOP 10 * FROM   countries c --note the alias 
where c.continent = 'EU'
 
-- Show 10 sample rows of the airports table

SELECT top 10 *
from airports a
where a.elevation_ft > 1000
order by a.elevation_ft desc


-- Show 10 sample rows of the airports_frequencies table
SELECT  TOP 10 * FROM airport_frequencies af
where af.fequency_mhz between 120 and 130
order by af.fequency_mhz desc

-- These are the more interesting columns of the airports table  that we use in this exercise
SELECT TOP 10
    a.ident
    , a.iata_code
    , a.name
    , a.[type] -- added in square brackets becasue 'type' is a SQL fucntion and [] needed to ID this as a field.
    , a.latitude_deg
    , a.longitude_deg
    , a.elevation_ft
    , a.iso_country
FROM airports a;
 
-- How many airports are in the airports table?
 SELECT count (distinct name) as [airport count]
 FROM  airports a;

Select count (*)  as [airport count]
 from airports;
 
 --are there any airports with the same name? 

Select a.name , count (*) as Numberofairports -- 1 row for each distinct name
from airports a
group by a.NAME
having count(*) > 1                            -- where clause and having cause -> having is used after the agregation. Where used before the group by (which is the agregation).
order by Numberofairports desc;

-- How many frequencies are in the airport_frequencies table?

 SELECT count (distinct af.fequency_mhz) 
 FROM  [dbo].[airport_frequencies] af;

 
-- How many airports of each type?

 SELECT count (*) as [count of airports], a.[type] as [Airport Type]
 FROM  airports a
 group by a.[type]
 order by [count of airports] desc;
 
-- Is the airport.ident column unique? i.e. there are no duplicate values
 
/*
Do a data quality check on the airports_frequencies table
Are there any orphan rows (frequencies without a matching airports)?
You can do this is several ways: LEFT JOIN, NOT IN, NOT EXISTS,...
*/
-- left join approach
 
-- NOT EXISTS approach  
 
-- NOT IN approach  
 
/*
1. List airports.  Show the following columns: ident, iata_code, name, latitude_deg, longitude_deg
2. Filter to those airports
  (a) of large_airports type
  (b) in the United Kingdom or France (iso_country  GB, FR)
  [advanced - in Europe i.e., country.continent = 'EU']
  (c) that have a latitude between 49 and 54 degrees
3. Order from the most northern airports to most southern airports
*/
 SELECT
    a.[ident]
    ,a.[name]
    ,a.[iata_code]
    ,a.[latitude_deg] 
    ,a.[longitude_deg]
    ,a.[type]
    ,a.iso_country
    ,b.continent
FROM
    [dbo].[airports] a

left join [dbo].[countries] b ON a.iso_country = b.code --left join so data in both tables

--can be done without the join: AND a.iso_country IN (SELECT code from a.countries where a.continent ='EU')

WHERE a.type LIKE '%large%'
    --AND a.[iso_country] IN ('GB','FR')
    AND b.[continent] = 'EU'
    AND a.latitude_deg BETWEEN '49' AND '54'




/*
List the iso_country of the 5 countries with the most airports
List in order of number of airports (highest first)
*/
 
 
/*
How many airports are in those 5 countries (with the most airports)?
Use three different approaches: temp table, CTE, subquery
*/
 
-- Write the temp table approach below here
 
 
-- Write the CTE approach below here
 
-- Write the subquery approach below here
 
/*
List those large airports (if any) without a frequency
*/
 
 
/*
List airports (if any) that have missing (NULL) values for *both* latitude or longitude.
*/
 
/*
List airports (if any) that have missing (NULL) values for *either* latitude or longitude  but not both.
This may indicate some sort of data quality issue.
*/

--football

Select *

FROM [dbo].[FootballMatch] m 