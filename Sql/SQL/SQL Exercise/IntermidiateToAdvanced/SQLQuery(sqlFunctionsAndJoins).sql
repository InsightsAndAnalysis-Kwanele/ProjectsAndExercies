--Ultimate database 

SELECT * FROM Building
SELECT * FROM Inspection
SELECT * FROM Applicant
SELECT * FROM Country
SELECT * FROM Tenant*/

--QUESTION 1
SELECT b.Bld_ID ,Bld_Name,Bld_Address,Ins_Date,DATENAME(mm,Ins_Date) AS MonthOfInspection,DATENAME(day,Ins_Date)AS DayOFInspection FROM Building b INNER JOIN  Inspection i on b.Bld_ID=i.Bld_ID WHERE DATENAME(day,Ins_Date)=30 or DATENAME(day,Ins_Date)=1 ORDER BY MonthOfInspection desc 


--QUESTION 2
SELECT CONCAT(App_Names ,' ' , App_Surname,'; ' , App_Cellphone) AS ApplicantInfo,Country_Name FROM Applicant a JOIN Country c on a.Country_ID=c.Country_ID


--QUSTION 3
SELECT  CONCAT(Ten_Name,' ',Ten_Surname) AS Tenent,datediff(yy,Ten_Date_OF_Birth,getdate()) AS TenantAge FROM Tenant  Order by TenantAge asc 