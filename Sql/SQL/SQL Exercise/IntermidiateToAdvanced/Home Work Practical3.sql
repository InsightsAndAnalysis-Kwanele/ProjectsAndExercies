SELECT * FROM BookingRepresentative
GO
SELECT * FROM Booking
GO

--QUESTION 1
SELECT Member_Name , Member_Surname , Picture FROM Member a, MemberPIcture b WHERE a.Member_ID=b.Member_ID
Go

--QUESTION 2
SELECT Date_Booking_Made , Booking_Number ,Booking_Status_Description FROM BookingStatus a ,Booking b WHERE a.Booking_Status_ID=b.Booking_Status_ID AND Booking_Status_Description LIKE '%Confirmed%'
GO

QUESTION 3
SELECT User_Name, Booking_Number , Date_Booking_Made, Booking_Session_Status FROM BookingSession a,Booking b WHERE a.Booking_Session_ID=b.Booking_Session_ID AND Booking_Session_Status LIKE 'Unavailable%'
GO


--QUESTION 4

SELECT Booking_Number , Date_Booking_Made ,Booking_Rep_Name ,Booking_Rep_Surname, Title_ID AS [Title_Name ] FROM BookingRepresentative a INNER JOIN Booking b on a.Booking_Rep_ID=b.Booking_Rep_ID;

Go