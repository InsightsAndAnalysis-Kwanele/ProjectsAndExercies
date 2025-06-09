--DBS socialhire database
--QUESTION 1
SELECT i.item_ID ,item_Name,Item_Specification,item_Question_Description,Item_Question_Answer FROM item i INNER JOIN Item_Questions q on i.item_ID=q.Item_ID WHERE Item_Question_Answer IS NOT NULL AND  item_Specification LIKE 'Black%'   ORDER BY item_ID 

--QUESTION 2
SELECT  item_Name, Rented_Start_Date,Rented_End_Date FROM item i LEFT OUTER JOIN Rented_item r on i.item_ID=r.item_ID WHERE  Rented_Start_Date  IS NOT NULL

--QUESTION 3
SELECT Rental_ID,Rental_Date,CONCAT(First_Name,'.',Last_Name) AS Clients FROM Rentals r RIGHT OUTER JOIN Client c on r.Client_ID=c.Client_ID ORDER BY Rental_ID

--QUESTION 4
SELECT r.Item_ID,item_Name,item_Specification,Rent_Return_Date,Complaint_Nature FROM (( Rented_item r INNER JOIN item i on r.Item_ID=i.Item_ID) INNER JOIN Complaint c on r.Rented_ID=c.Rented_ID) WHERE Rent_Return_Date>'2011-12-31'