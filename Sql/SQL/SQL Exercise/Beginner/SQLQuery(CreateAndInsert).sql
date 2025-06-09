USE Master
Go
if exists( SELECT * from sys.databases where name ='STUDENTS')
DROP DATABASE STUDENTS
Go

CREATE DATABASE STUDENTS
Go
 CREATE TABLE STUDENT
 (
  STUDENT_StudentID int Identity(1,1) Primary Key Not Null,
  STUDENT_Name varchar(255) Not Null,
  STUDENT_Surname varchar(255) Not Null,
  STUDENT_YearAvg varchar(255) Not Null,
  STUDENT_Promotion varchar(255) Not Null
 )
 Go

 CREATE TABLE TRIP
 (
 TRIP_InvoiceID int Identity(1,1) Primary Key Not Null,
 STUDENT_StudentID int references STUDENT(STUDENT_StudentID),
 TRIP_CouponFor varchar(255) Not null,
 TRIP_Price int Not null,
 TRIP_Date Date Not null
 )
 Go

 INSERT INTO STUDENT values
 ( '30476','Kwanele','Buthelezi','85.1','Promoted') 
 Go


