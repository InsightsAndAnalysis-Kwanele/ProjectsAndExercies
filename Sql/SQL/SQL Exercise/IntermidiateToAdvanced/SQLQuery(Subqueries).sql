--Dasport Clinic database
--QUESTION 1.1
SELECT c.Patient_No, Name,Surname,Citizenship,Consult_No,Con_Weight FROM Patient p inner join Consultation c on p.Patient_No=c.Patient_No WHERE p.Patient_No IN (SELECT Patient_No FROM Consultation WHERE Con_Weight <(SELECT AVG(Con_Weight) FROM Consultation ))

--QUESTION 1.2 

SELECT Hosp_Name ,Hosp_Address FROM Referral_Hospital WHERE Hosp_Province in (SELECT Clinic_Province FROM Referral_Clinic WHERE Clinic_Province in ( SELECT Province_ID from Province WHERE Province_Name='Gauteng') )


--QUESTION 1.3
SELECT p.Patient_No,Name,Surname,Province_ID,Con_Hist_BMI FROM Patient p inner join Consultation c on p.Patient_No=c.Patient_No WHERE Con_Hist_BMI in (SELECT MAX(Con_Hist_BMI) FROM Patient p inner join Consultation c on p.Patient_No=c.Patient_No GROUP BY Province_ID) ORDER BY Province_ID ASC