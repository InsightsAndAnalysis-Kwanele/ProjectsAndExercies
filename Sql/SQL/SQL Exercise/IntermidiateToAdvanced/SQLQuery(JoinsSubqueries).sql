--QUESTION 1
SELECT Stock_Item_Name,Stock_Item_Description,r.Stock_Returned_Date FROM Stock s inner join StockReturned r on s.Stock_Item_ID=r.Stock_Item_ID  WHERE r.Stock_Returned_Date IN (SELECT MAX(Stock_Returned_Date) FROM StockReturned ) GROUP BY Stock_Item_Name,Stock_Item_Description,r.Stock_Returned_Date


--QUESTION 2
SELECT Employee_ID ,Employee_Name,Employee_Surname FROM Employee WHERE Employee_ID NOT in (SELECT Employee_ID FROM CheckIN )

--QUESTION 3
SELECT Stock_Item_Name,Stock_Item_Description FROM Stock WHERE Stock_Item_ID in (SELECT Stock_Item_ID FROM StockWriteOff WHERE Stock_Item_ID IN (SELECT Stock_Item_ID FROM StockReturned)) 

--QUESION 4
SELECT Payment_ID,Payment_Amount,Payment_Date from Payment WHERE Member_ID IN (SELECT Member_ID FROM Member)