SELECT * FROM LayOffs

-----------------------------------------------------------------------------
---------------------------REMOVING DUPLICATES

--1.CHecking for Duplicates

SELECT company,[location],industry,total_laid_off,percentage_laid_off,date,COUNT(*) AS NumOfRecords
FROM LayOffs 
GROUP BY company,[location],industry,total_laid_off,percentage_laid_off,date
HAVING COUNT(*)>1

--2.Removing duplicates

SELECT *    -----copying the data into another table in case we make human error
INTO DirtyData
FROM LayOffs

SELECT * FROM DirtyData;

WITH remRow as(
SELECT *, ROW_NUMBER() OVER(PARTITION BY company,[location],industry,total_laid_off,percentage_laid_off,[date] ORDER BY company) AS RowNumber 
FROM DirtyData
)

DELETE FROM remRow WHERE RowNumber>1

SELECT * FROM DirtyData

--checcking for duplicates again

SELECT company,[location],industry,total_laid_off,percentage_laid_off,date,COUNT(*) AS NumOfRecords
FROM DirtyData
GROUP BY company,[location],industry,total_laid_off,percentage_laid_off,date
HAVING COUNT(*)>1



------------------------------------------------------
-------------------HANDLING NULL VALUES

SELECT * FROM DirtyData WHERE industry='' or industry is null;


-----1.Inddustry coloumn

UPDATE d1
SET d1.industry=d2.industry
FROM DirtyData d1 JOIN DirtyData d2
ON d1.company=d2.company
WHERE ((d1.industry is NULL) or (d1.industry='') OR (d1.industry='NULL')) and  (d2.industry IS not NULL)  

----1.1 else if populating with the nearest related record does not work populate Set it to 'other'
UPDATE DirtyData
SET industry='Other'
WHERE industry is null or (industry='') or industry='NULL'

--checking for remaining nulls
SELECT * FROM DirtyData where (industry='') or (industry is null) OR ( industry='NULL')


----2.Total laid off coloumn
---checking for nulls
SELECT * FROM DirtyData WHERE (total_laid_off='') OR (total_laid_off is null) OR (total_laid_off='NULL') ORDER BY company; 


----populating nulls with related records ,this time with an average
WITH NumOfComp as (
SELECT company,location,AVG(Cast(total_laid_off AS float)) AS AVERAGE FROM DirtyData WHERE ISNUMERIC(total_laid_off)=1  GROUP BY company,location
)

UPDATE dd
SET dd.total_laid_off=nc.AVERAGE
FROM DirtyData dd JOIN NumOfComp nc
ON dd.company=nc.company and dd.[location]=nc.[location]
WHERE (dd.total_laid_off is null) or (dd.total_laid_off='') or (dd.total_laid_off='NULL')


-----Remaining null values with no related records set with the table average
UPDATE DirtyData
SET total_laid_off=(SELECT AVG(CAST(total_laid_off AS FLOAT)) FROM DirtyData where ISNUMERIC(total_laid_off)=1)
WHERE  (total_laid_off is null) or (total_laid_off='') or (total_laid_off='NULL') 

----checking for ramaining null values
SELECT * FROM DirtyData ORDER BY company,location-- WHERE  (total_laid_off='') OR (total_laid_off is null) OR (total_laid_off='NULL') ORDER BY company; 


----3.percantage laid off

WITH TotEmployees as (
SELECT company,location,total_laid_off,percentage_laid_off,((CAST(total_laid_off AS FLOAT))/(CONVERT(decimal(10,2),percentage_laid_off))) as totalEmployees FROM DirtyData WHERE ISNUMERIC(total_laid_off)=1 and ISNUMERIC(percentage_laid_off)=1 and percentage_laid_off>0
)