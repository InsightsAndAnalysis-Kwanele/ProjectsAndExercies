SELECT * FROM LayOffs

---------------------------------DATA CLEANING--------------------------------------------------
-------------------------------------------------------------------------------------------------

SELECT *   -----------------------creating a seperate table to work on
INTO Sample_Layoffs
FROM LayOffs

SEleCT * FROM Sample_layoffs;



--------------------------------------------------------------
-------------------1.REMOVING DUPLICATES
WITH dupl as(
SELECT *,ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,[date],stage,country,funds_raised_millions ORDER BY company) as Row_num
FROM Sample_Layoffs )
SELECT * FROM dupl WHERE Row_num>1 ;  ------------------checking for duplicates

WITH remDupl AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,[date],stage,country,funds_raised_millions ORDER BY company) as Row_num
FROM Sample_Layoffs 
)
DELETE FROM remDupl WHERE Row_num>1

SELECT * FROM Sample_layoffs WHERE company LIKE '%@%'











------------------------------------STANDARDIZING DATA------------------

UPDATE Sample_Layoffs  ------Company coloumn
SET company=TRIM(company)




------checking the industry coloumn

SELECT distinct industry
FROM Sample_Layoffs ORDER BY 1


-----fixing records in the industry coloumn to ensure consistency (records which should share the smae name)

UPDATE Sample_Layoffs
SET industry='Crypto'
WHERE industry like 'Crypto%'

----checking the country coloumn
SELECT DISTINCT country FROM Sample_Layoffs
ORDER BY 1

----UPDATING COUNTRY seperated by human error

UPDATE Sample_Layoffs
SET country=TRIM(TRAILING '.' FROM country)
WHERE country like 'United States%'



--------------standardizng the date
SELECT [date],CAST([date] AS DATE) from Sample_Layoffs WHERE ISDATE([date])=1

UPDATE Sample_Layoffs
SET [date]=CAST([date] AS DATE)
WHERE ISDATE([date])=1



SELECT * FROM Sample_Layoffs

UPDATE Sample_Layoffs
SET [date] =NULL
WHERE [date]='Null'

ALTER TABLE Sample_Layoffs
ALTER COLUMN  [date] date;



------------------------------DEALING WITH NULLS AND BLANKS--------------------------
SELECT company,industry FROM Sample_layoffs WHERE industry = 'NULL' or industry=''


---populating industry rows with similar records

UPDATE Sample_Layoffs
SET industry=NULL
WHERE industry='Null' or industry=''

SELECT * FROM Sample_Layoffs sl1 JOIN Sample_Layoffs sl2
ON sl1.company=sl2.company
WHERE ((sl1.industry is null) OR (sl1.industry like 'Null%') or (sl1.industry='')) and (sl2.industry IS NOT NULL )

UPDATE sl1
SET sl1.Industry=sl2.industry
FROM Sample_Layoffs sl1 JOIN Sample_Layoffs sl2
ON sl1.company=sl2.company
WHERE ((sl1.industry is null) OR (sl1.industry like 'Null%') or (sl1.industry='')) and (sl2.industry IS NOT NULL )

SELECT * FROM Sample_layOffs WHERE industry IS NULL



----populating remaning null
UPDATE Sample_Layoffs
SET industry='not provided'
WHERE industry IS NULL


---------------total and percantage laid off coloumns
UPDATE Sample_Layoffs
SET total_laid_off=Null
WHERE total_laid_off='Null' or total_laid_off=''

UPDATE Sample_Layoffs
SET percentage_laid_off=Null
WHERE percentage_laid_off='Null' or percentage_laid_off=''


SELECT * FROM Sample_Layoffs WHERE (total_laid_ofF IS  NULL) and (percentage_laid_off is null)

-----removing these records we might not use in data exploration

DELETE FROM Sample_Layoffs WHERE (total_laid_ofF IS  NULL) and (percentage_laid_off is null)

SELECT * FROM Sample_Layoffs 

