SELECT * FROM Sheet1$


--------------------------------------------------
----------------------REMOVING DUPLICATES-
---------

SELECT CustomerID,CustomerName,Email,Phone,Count(*) AS Duplictes 
FROM Sheet1$
GROUP BY CustomerID,CustomerName,Email,Phone;  ---Checking for repeated rows


---creating a seperate table to do the cleaning on to not lose the og data incase we make mistakes
SELECT * 
INTO DirtyData
FROM Sheet1$


SELECT * FROM DirtyData;

-------removing the repeated rows

with remData as (
  SELECT * ,ROW_NUMBER() OVER(PARTITION BY CustomerID,CustomerName,Email,Phone ORDER BY CustomerID ASC) as NumOfRows
  FROM DirtyData 
)

DELETE FROM remData WHERE NumOfRows>1



-------------------------------------------------------------------
-----------------------------------DEALING WITH NULLS

--checking the number of nulls we have 
SELECT * FROM DirtyData;
SELECT 
SUM(CASE WHEN CustomerName IS NULL then 1 ELSE 0 END ) AS nullCustIDs,
SUM(CASE WHEN Email IS NULL then 1 ELSE 0 END) as nullEmails,
SUM(CASE WHEN Phone IS NULL then 1 ELSE 0 END) nullPhoneNumbers,
SUM(CASE WHEN OrderDate IS NULL then 1 ELSE 0 END ) nullOrderDates ,
SUM(CASE WHEN OrderAmount IS NULL then 1 ELSE 0 END ) nullOrderAmounts
FROM DirtyData

-----Replacing Null Values


UPDATE DirtyData  ----FOR customer names
SET CustomerName='Unknown'
WHERe CustomerName is null

SELECT * FROM DirtyData

UPDATE DirtyData-----FOR emails
SET Email='Not Provided'
WHERE Email is null

SELECT * 
from DirtyData d1 join DirtyData d2
ON d1.Email=d2.Email 
WHERE (d1.Phone is null) and (d2.Phone is not null)

UPDATE d1------For Phone numbers where a phone number who has an existing phone number is not entered into the database
SET d1.Phone= d2.Phone
from DirtyData d1 JOIN DirtyData d2
ON d1.Email=d2.Email
WHERE (d1.Phone is Null) and (d2.Phone is not null)

SELECT * FROM DirtyData

select AVG( CAST(OrderAmount AS FLOAT)) FROM DirtyData


UPDATE DirtyData-----------Populating the null records with the average amount
SET OrderAmount=(select AVG( CAST(OrderAmount AS FLOAT)) FROM DirtyData)
WHERE OrderAmount Is null


---Checking remaining nulls

SELECT * FROM DirtyData WHERE 
    CustomerName IS NULL OR 
    Email IS NULL OR 
    Phone IS NULL OR 
    OrderAmount IS NULL;



---------------------------------------------------------------------------
------------------------STANDARDIZING TEXT

UPDATE DirtyData ------REMOVING WHITE SPACES 
SET CustomerName= TRIM(Upper(substring(CustomerName,1,1)) + Lower(substring(CustomerName,2,len(CustomerName)-1))),
    Email=TRIM(Lower(Email)),
	Phone=TRIM(Phone),
	OrderDate=Trim(OrderDate),
	OrderAmount=OrderAmount

SELECT * FROM DirtyData
SELECT CustomerID,Replace(CustomerName,'@','a'),Email,Phone,OrderDate,OrderAmount FROM DirtyData

UPDATE DirtyData---------Removing a special character
SET CustomerName=Replace(CustomerName,'@','a')




-----------STANDARDIZING DATE FORMATS
SELECT * FROM DirtyData
SELECT CONVERT(nvarchar(55), CAST(OrderDate as DATE),23) FROM DirtyData WHERE ISDATE(OrderDate)=0-----checking for invalid dates

UPDATE DirtyData-------CONVERTING VALID DATES
SET OrderDate=CONVERT(nvarchar(55), CAST(OrderDate as DATE),23)
WHERE ISDATE(OrderDate)=1


UPDATE DirtyData-------trying to converting invalid dates
SET OrderDate = TRY_CONVERT(DATE, OrderDate, 107)  
WHERE ISDATE(OrderDate) = 0;



UPDATE DirtyData-----filling null dates
SET OrderDate = GETDATE()
WHERE ISDATE(OrderDate) = 0 OR OrderDate IS NULL;
UPDATE DirtyData-------CONVERTING VALID DATES again
SET OrderDate=CONVERT(nvarchar(55), CAST(OrderDate as DATE),23)
WHERE ISDATE(OrderDate)=1








----------------------------------------
---------------VALIDATING THE DATA SET

SELECT * 
FROM DirtyData   -----------------CHECKING FOR ANY REMAING NULL VALUES
WHERE CustomerName IS NULL OR Email IS NULL OR Phone IS NULL OR OrderAmount IS NULL OR OrderDate IS NULL;


----------------------------------
--------CREATING A NEW TABLE
SELECT *
INTO CleanedData
FROM DirtyData


drop table DirtyData ---deletimg the old table
SELECT * FROM CleanedData
SELECT * FROM Sheet1$


