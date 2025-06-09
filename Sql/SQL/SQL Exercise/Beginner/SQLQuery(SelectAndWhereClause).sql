--Dasport Clinic database
SELECT * FROM Patient WHERE NOT Gender like 'FeMale%' AND CitizenShip='South African' OR Date_Of_Birth LIKE '1989%' ORDER BY Province_ID 


SELECT DISTINCT CitizenShip,Gender FROM Patient WHERE Gender='Male'


Select *  FROM Prescription

Select Name, Surname,Presc_ID,History_ID Gender,Date_Of_Birth,c.Patient_No FROM Patient p JOIN Prescription c on p.Patient_No=c.Patient_No WHERE ID_Number like '91%' ORDER BY Date_Of_Birth desc 


SELECT Patient_No, Name,Surname,ID_Number FROM Patient WHERE ID_Number='' ;
Go