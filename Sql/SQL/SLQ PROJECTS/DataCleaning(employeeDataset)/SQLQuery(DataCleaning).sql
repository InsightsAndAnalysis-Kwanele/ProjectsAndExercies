SELECT * FROM Dirty_Employees;

SELECT *
INTO cleaningData--creating a different table to work on just in case we make mistakes during the cleaning process
FROM Dirty_Employees;

SELECT * FROm cleaningData;

--Step 1 Finding and removing duplicates
with tblDupl as (
SELECT 
	EmployeeID,EmployeeName,Email,Department,Position,Salary,HireDate,
	ROW_NUMBER() OVER(PARTITION BY EmployeeName Order by EmployeeID ) AS [RowNum] --I am finding similar Employee Names but different departments,these might be just people with similar names in deifferent departments, however since there are a lot of these instances and this is practice I wil assume this is a data entry mistake and will remove the duplicates
FROM cleaningData

)
DELETE FROM tblDupl where RowNum>1 --18 duplicates found and removed

SELECT * FROM cleaningData

--still finding similar names due to the the trailing spaces thus we will stndardize the EmployeeName coloumn
UPDATE cleaningData
SET EmployeeName=TRIM(EmployeeName)
SELECT * FROM cleaningData;

--copy and paste the previous cte
with tblDupl as (
SELECT 
	EmployeeID,EmployeeName,Email,Department,Position,Salary,HireDate,
	ROW_NUMBER() OVER(PARTITION BY EmployeeName Order by EmployeeID ) AS [RowNum] --I am finding similar Employee Names but different departments,these might be just people with similar names in deifferent departments, however since there are a lot of these instances and this is practice I wil assume this is a data entry mistake and will remove the duplicates
FROM cleaningData

)
DELETE FROM tblDupl where RowNum>1 --found and removed 19 more duplicates

SELECT * FROM cleaningData WHERE( EmployeeName IS NULL) or EmployeeName=''--no null values in the names coloumn
SELECT * FROM cleaningData WHERE EmployeeName LIKE 'Bob%' --trying to understand the names and making sure there are unique values

--HANDLING THE EMAILS COLOUMN
SELECT * FROM cleaningData WHERE (Email is null) or (Email=' ')--3 rows from the emali col had null values

UPDATE cleaningData
SET Email='not provided'
WHERE (Email is null) or (Email=' ') --removed all null rows from email and populated them with 'not provided'  for easier anlysis
--we could have used joins to populate the emails but given that each row is supposed to have a unique EmployeeID and EmployeeName, the email,also can only belong to one row/individual

SELECT * FROM cleaningData

--#removing unnecesary special characters from the emails colomn
SELECT COUNT(*) FROM cleaningData WHERE (Email like '%@@%') or (Email like '%..%') --40 records that have unnecesry special charcters

UPDATE cleaningData
SET Email=TRIM(REPLACE( Replace(Email,'@@','@'),'..','.')) 

SELECT * FROM cleaningData

--HANDLING THE Department COLOUMN
SELECT Count(*) as [NumOfNullsIn Department Coloumn] FROM cleaningData WHERE (Department='') or (Department is NULL)--0  null or empty strings

SELECT * FROM cleaningData --find incorrect formating uncapitalized and apitalized values of the same string making the different due to SQL case sensetivity
UPDATE cleaningData
SET Department=TRIM(Department)--removing all trailing spaces

SELECT Department from cleaningData

UPDATE cleaningData
SET Department=CONCAT(UPPER(Substring(LOWER(Department),0,2)),SUBSTRING(LOWER(Department),2,10)) --creating consistent formatting


SELECT * FROM cleaningData 

--HANDLING THE Position coloumn
SELECT COUNT(*) as [EmptyColInThePositionCol] FROM cleaningData WHERE Position='' or Position is null --ten null rows in the position coloumn

UPDATE cleaningData
SET Position='not stated'
WHERE Position='' or Position is null

UPDATE cleaningData
SET Position=TRIM(Position) --just in case there might be any trailing spaces

--HANDLING THE Salary Coloumn
UPDATE cleaningData
SET Salary= TRY_CAST(Salary AS INT) --changing the datatype to a float

SELECT Salary From cleaningData where (Salary='') or (Salary is null) or (Salary=0)--0 because all the epty string were converted to floats ,and we can not have o for salary so we have to change it
--found 10 '0' or nulls
SELECT Salary From cleaningData where  (Salary<0) --checking for negative values
--11 negative values were found

UPDATE cleaningData
SET Salary=Salary*-1  --assuming the the negative was placed by mistake(in the data entry prcocess)
where  (Salary<0) 

SELECT ROUND(AVG(TRY_CAST(Salary AS FLOAT)),2) FROM cleaningData 

SELECT Salary FROM cleaningData
UPDATE cleaningData
SET Salary=(SELECT ROUND(AVG(TRY_CAST(Salary AS FLOAT)),2) FROM cleaningData)   --populating the zeros by the average value in the coloumn 
where  (Salary=0) or (Salary is null)

SELECT * FROM cleaningData

--HANDLING THE HireDate COLOUMN
UPDATE cleaningData
SET HireDate=Replace(replace(REPLACE(Replace(HireDate,'"',''),',',''),' ','-'),'/','-')  --removing certain unwanted characters

SELECT Replace(HireDate,'July-15-2021','07-15-2021') FROM cleaningData where HireDate='July-15-2021'--looking at regular occurances and trying to change them manualy like the date July 15th

UPDATE cleaningData
SET HireDate=Replace(HireDate,'July-15-2021','07-15-2021') --changing them
WHERE HireDate='July-15-2021'

select HireDate from cleaningData WHERE HireDate='2021-02-30' --1
SELECT Try_Convert(date,HireDate) FROM cleaningData WHERE Try_Convert(date,HireDate ) IS nULL --2 Checking and finding rgular occurances where dates that are similar are chAnged into null,thus we must update and fix these rows fisrt using an update

UPDATE cleaningData
SET HireDate='2021-02-28'
WHERE HireDate='2021-02-30' ---February does not have day 30!

SELECT Try_Convert(date,HireDate) FROM cleaningData --now all values can be converted

UPDATE cleaningData
SET HireDate=Try_Convert(date,HireDate) --updating the dates

SELECT * FROM cleaningData

---------------MOVING THE CLEANED data set to a new table
SELECT * 
INTO Clean_Employees
FROM cleaningData

SELECT * FROM Clean_Employees
DROP TABLE cleaningData
