SELECT * FROM tblsample

-------------------------------
--------REMOVING DUPLICATES

--1.Checking for duplicates
SELECT CustomerID,CustomerName,Email,Phone,COUNT(*) AS Records
FROM tblsample
GROUP BY CustomerID,CustomerName,Email,Phone;


--1.2 Creating a different table to work on to not loose original data
SELECT *
INTO DirtySample
FROM tblsample

SELECT * FROM DirtySample;

--2.Removing the ones that have duplicates

WITH duplRecorcd as(
SELECT CustomerID,CustomerName,Email,Phone,ROW_NUMBER() OVER(PARTITION BY CustomerID,CustomerName,Email,Phone ORDER BY CustomerID ) AS RecordOrd
FROM DirtySample
)

DELETE FROM duplRecorcd WHERE RecordOrd>1

SELECT * FROM DirtySample
INSERT INTO DirtySample(CustomerID,CustomerName,Phone,OrderDate)
VALUES(112,'Tom Holland','060 731 4124',2024-03-15)
go


------------------------------------------------------------------
-----------------------HANDLING NULL VALUES
---1.cHECK FOR NULLS

SELECT  
   SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END  ) AS nullIds,
   SUM(CASE WHEN CustomerName IS NULL THEN 1 ELSE 0 END  ) AS nullNames,
   SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END  ) AS nullEmails,
   SUM(CASE WHEN Phone IS NULL THEN 1 ELSE 0 END  ) AS nullPhoneNumbers,
   SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END  ) AS nullDates,
   SUM(CASE WHEN OrderAmount IS NULL THEN 1 ELSE 0 END  ) AS nullAmounts
FROM DirtySample 
WHERE (CustomerID IS NULL)
    or CustomerName IS NULL
    or (Email is null)
	or (Phone is null)
	or (OrderDate IS NULL)
	or (OrderAmount is null)

---2.Try to fill the null rows
SELECT * FROM dirtySample

-----if a the customer name has null values , we check if the are rows that share some of the information with the null row customer name
INSERT INTO DirtySample(CustomerID,Phone,OrderDate,OrderAmount)
VALUES(105,'456-789-1234',2024-03-15,200)
go              ---------if information was possibly added and it had missing information due to human error
--------------------------------

---checking missing information with related records
SELECT * 
FROM DirtySample ds1 JOIN DirtySample ds2
ON ds1.CustomerID=ds2.CustomerID
WHERE (ds1.CustomerName is null) and  (ds2.CustomerName is not null)

---updating the information

UPDATE ds1
SET ds1.CustomerName=ds2.CustomerName
FROM DirtySample ds1 JOIN DirtySample ds2
ON ds1.CustomerID=ds2.CustomerID
WHERE (ds1.CustomerName is null) and  (ds2.CustomerName is not null)



SELECT * FROM DirtySample

-----Chencking for remaining nulls in the customer coloumn
SELECT * FROM DirtySample where CustomerName is null
-----------under carefull inspection and context removing records that will not be usefull in analysis
DELETE FROM DirtySample WHERE CustomerName is null
SELECT * FROM DirtySample ORDER BY CustomerID



---adding costomer ID too null cust Ids
UPDATE DirtySample  ----------Only because there is only one record left  and it looks important to the table
SET CustomerID = (SELECT MAX(CustomerID)+1 FROM DirtySample)
WHERE CustomerID is null

SELECT * FROM DirtySample  ORDER BY CustomerID

-----------------removing nulls from emails
UPDATE ds1  ---------nulls that have similar records
SET ds1.Email=ds2.Email
FROM DirtySample ds1 JOIN DirtySample ds2
ON ds1.CustomerID=ds2.CustomerID
WHERE (ds1.Email is null) and  (ds2.Email is not null)
SELECT * FROM DirtySample  ORDER BY CustomerID

---if no email is provided populate with a string

UPDATE DirtySample
SET Email='not provided'
WHERE Email is null
SELECT * FROM DirtySample  ORDER BY CustomerID


----------removing nulls from phone numbers
UPDATE ds1  ---------nulls that have similar records
SET ds1.Phone=ds2.Phone
FROM DirtySample ds1 JOIN DirtySample ds2
ON ds1.CustomerID=ds2.CustomerID
WHERE (ds1.Phone is null) and  (ds2.Phone is not null)
SELECT * FROM DirtySample  ORDER BY CustomerID

---if no phone is provided populate with a string

UPDATE DirtySample
SET Phone='000-0000-000'
WHERE Phone is null
SELECT * FROM DirtySample  ORDER BY CustomerID;


----------removing nulls from orderDae coloumn
WITH AvgDate as(
SELECT CAST(CAST(AVG(CAST(CONVERT(DATETIME, OrderDate, 120) AS FLOAT)) AS DATETIME) AS DATE) as myAvgDate
FROM DirtySample 
WHERE ISDATE(OrderDate)=1
)

UPDATE DirtySample  -------replacing the null date with the average date
SET OrderDate= (SELECT myAvgDate FROM AvgDate)
WHERE OrderDate IS NULL

SELECT * FROM DirtySample  ORDER BY CustomerID


---------removing nulls from the order amount table
With avgAmount as (
SELECT Avg(OrderAmount) myAvgAmount from DirtySample 
)

UPDATE DirtySample
SET OrderAmount=(Select myAvgAmount from avgAmount)
WHERE OrderAmount IS NULL

SELECT * FROM DirtySample  ORDER BY CustomerID







-----------------------------------------------------------------------
---------------------------------------STANDARDIZING TEXT
--1.Removing spaces and capitazlizing the names
UPDATE DirtySample
SET CustomerName= LOWER(TRIM(CustomerName))

UPDATE DirtySample
SET CustomerName=UPPER(SUBSTRING(CustomerName,1,1))+Substring(CustomerName,2,LEN(CustomerName)-1)

SELeCT * FROM DirtySample

--2.lower casing the emails
UPDATE DirtySample
SET Email=LOWER(Email)

--3.removing any special character from the phone numbers

SELECT REPLACE(Phone,'-','') FROM DirtySample
UPDATE DirtySample
SET Phone=REPLACE(Phone,'-','')
UPDATE DirtySample
SET Phone=REPLACE(Phone,' ','')
UPDATE DirtySample
SET Phone=REPLACE(Phone,'.','')
SELeCT * FROM DirtySample

UPDATE DirtySample
SET Phone=REPLACE(Phone,'(','')
UPDATE DirtySample
SET Phone=REPLACE(Phone,')','')


----------------------------------------------------------
---------------------------STANDARDIZING DATE formats
SELECT * FROM DirtySample WHERE ISDATE(OrderDate)=0 ----checking for non date 

SELECT CAST(OrderDate AS DATE) AS NewDate FROM DirtySample WHERE ISDATE(OrderDate)=1

UPDATE DirtySample
SET OrderDate=CAST(OrderDate AS DATE)
WHERE ISDATE(OrderDate)=1

--using try convert to format the remaining dates 
UPDATE DirtySample
SET OrderDate=Try_CONVERT(DATE, OrderDate, 103)
WHERE ISDATE(OrderDate)=0
SELECT * FROM DirtySample
--populating the remaining null from the try convert functions
UPDATE DirtySample
SET OrderDate='no date provided'
WHERE OrderDate IS NULL
SELECT * FROM DirtySample


SELECT *
INTO CleanSampleSet
FROM DirtySample

SELECT * FROM CleanSampleSet



DROP TABLE DirtySample
