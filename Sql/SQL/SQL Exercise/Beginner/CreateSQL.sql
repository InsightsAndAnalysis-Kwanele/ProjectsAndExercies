Use Master
Go
If Exists (Select * from sys.databases where name = 'myBooks')
DROP DATABASE myBooks
Go

Create Database myBooks
Go
  
  CREATE TABLE PUBLISHER
  (

  Publisher_ID int Identity(1,1) Primary Key Not Null,
  Publisher_Name varchar(255) Not Null

  )
 
 Go

 CREATE TABLE AUTHOR
 (
 Author_ID int Identity(1,1) Primary Key Not Null,
 AuthorName varchar(255), 
 )

 Go

 CREATE TABLE BOOK
 (
 Book_ID int Identity(1,1) Primary Key Not Null,
 Author_ID int references AUTHOR(Author_ID),
 Book_Name varchar(250),
 Book_Genre varchar(250)
 )

Go

CREATE TABLE BOOKPUBLISHER
(
Book_ID int references BOOK(Book_ID),
Publisher_ID int references PUBLISHER(Publisher_ID),
Release_Date date ,
)
Go
