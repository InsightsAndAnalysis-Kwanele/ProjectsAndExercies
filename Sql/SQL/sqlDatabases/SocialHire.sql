Use Master
Go
If Exists (Select * from sys.databases where name = 'DBSocialHire')
DROP DATABASE DBSocialHire
Go
Create Database DBSocialHire
Go

Use DBSocialHire
Go

CREATE TABLE User_Access
(
User_ID int Identity (1,1) Primary Key Not Null,
User_Description char (20) not null 
)
GO

CREATE TABLE Province
(
Province_ID int Identity (1,1) Primary Key Not Null,
Province_Name varchar (30) not null 
)
GO
CREATE TABLE City
(
City_ID int Identity (1,1) Primary Key Not Null,
City_Name varchar (30) not null,
Province_ID int references Province(Province_ID)

)
GO

CREATE TABLE Suburb
(
Suburb_ID int Identity (1,1) primary key Not Null,
Suburb_Name varchar (30) NOT NULL,
City_ID int references City (City_ID)
)
GO
CREATE TABLE Category
(
Category_ID int Identity (1,1) Primary Key Not Null,
Category_Name varchar(50) not null unique
)
GO
CREATE TABLE Default_Image
(
Image_ID int Identity (1,1) Primary Key Not Null,
Image_Description varchar (20),
Profile_Image varchar(100)
)
GO

CREATE TABLE Image_Status
(
Image_Status_ID int Identity (1,1) Primary Key Not Null,
Image_Status_Description varchar (20) not null
)
GO

CREATE TABLE Security_Questions
(
Security_Questions_ID int Identity (1,1) Primary Key Not Null,
Security_Description varchar(200) not null,
)
GO

CREATE TABLE Gender
(
Gender_ID int Identity (1,1) Primary Key Not Null,
Gender_Description varchar(6) not null
)
GO

CREATE TABLE User_Status
(
UserStatus_ID int Identity (1,1) Primary Key Not Null,
UserStatus_Description varchar (20) not null
)
GO

CREATE TABLE Item_Status
(
ItemStatus_ID int Identity (1,1) Primary Key Not Null,
ItemStatus_Description varchar (20) not null
)
GO

CREATE TABLE Client
(
Client_ID int Identity (1,1) Primary Key Not Null,
First_Name varchar(30) not null,
Last_Name varchar(30) not null,
Physical_Address varchar(100) not null,
Cell_Phone varchar(10)Not Null,
Landline varchar(10),
Office_Number varchar(10),
Email_Address varchar (50)Not Null,
UserName varchar(20)Not Null,--Website username
Client_Password varchar(20)Not Null,
Client_Security_Answer varchar (50) not null,
Client_Account_Username varchar(50)Not Null,--Paypal username
Client_Image_Name varchar(50),
Client_Image varchar(max),
ID_Number varchar (100) Not Null,
ID_Name varchar(250),
ID_Document varchar(max),
Client_Blocked bit not null,
Client_Blocked_Reason varchar(150),
Client_Flagged bit not null,
Client_Verification_Status bit not null,
Client_Average_Rate int,
NOKFirst_Name varchar(30)Not Null,
NOKLast_Name varchar(30)Not null,
NOKCell_Phone varchar (10)Not Null,
NOKTelephone varchar (10),
NOKEmail_Address varChar (50)Not Null,
Regristration_Date datetime not null,
Image_ID int FOREIGN KEY references Default_Image(Image_ID),
User_ID int FOREIGN KEY references User_Access(User_ID),
Image_Status_ID int FOREIGN KEY references Image_Status(Image_Status_ID),
Client_Security_Question int FOREIGN KEY references Security_Questions(Security_Questions_ID),
UserStatus_ID int FOREIGN KEY references User_Status(UserStatus_ID),
Gender_ID int FOREIGN KEY references Gender(Gender_ID)
)
GO
CREATE TABLE Item
(
Item_ID Int Identity(1,1) Primary Key Not Null,
Item_Name varchar(100) not null,
Item_Specification varchar(250),
Item_Deposit_Fee int NOT NULL,
Item_Image_Name varchar(100),
Item_Image varchar(max) ,
Item_Address varchar(250),
Item_Date_Added datetime not null,
Item_Blocked_Reason varchar(150) ,
Item_Monthly_Fee Decimal NOT NULL,
Item_Weekly_Fee Decimal NOT NULL,
Item_Daily_Fee Decimal NOT NULL,
Item_Flagged bit Not Null ,
Item_Average_Rating int,
Item_OnHold_Date datetime,
Item_Onhold bit Not Null,
Item_Client_Holder varchar(10),--person who placed the item on hold
Item_Blocked bit Not Null,
Item_Suggested_Category varchar(20),
Category_ID int references Category(Category_ID),
Image_ID int references Default_Image(Image_ID),
Client_ID int references Client(Client_ID),
Image_Status_ID int references Image_Status(Image_Status_ID),
Suburb_ID int references Suburb(Suburb_ID),
ItemStatus_ID int references Item_Status(ItemStatus_ID)
)
GO

CREATE TABLE Charge_Rate
(
Rate_ID Int Identity (1,1) Primary Key Not Null,
Rate_Description varchar(20),
Rate_Percentage int
)
GO

CREATE TABLE Reported_Images
(
Report_ID int Identity (1,1) Primary Key Not Null,
Report_Reason varchar(50),
Report_Date datetime,
Client_ID int references Client(Client_ID),
Item_ID int  references Item(Item_ID) Null
)
GO

CREATE TABLE Notifications
(
Notification_ID int Identity (1,1) Primary Key Not Null,
Notification_Description varchar(100),
Notification_Date datetime,
Client_ID int references Client(Client_ID)
)
GO

CREATE TABLE Administrator
(
Admin_ID int Identity (1,1) Primary Key Not Null,
Title varchar(10),
First_Name varchar(30),
Last_name varchar(30),
Username varchar(20),
Admin_Password varchar(20),
Telephone varchar (10),
Cellphone varchar (10),
Physical_Address varchar(100),
ID_Number varchar(13),
Area_Code int,
Email_Address varchar(50),
Security_Answer varchar(100),
User_ID int references User_Access(User_ID),
Security_Questions_ID int references Security_Questions(Security_Questions_ID),
Gender_ID int FOREIGN KEY references Gender(Gender_ID),
UserStatus_ID int FOREIGN KEY references User_Status(UserStatus_ID)
)
GO

CREATE TABLE AdminAudit_Log
(
Audit_ID int Identity (1,1) Primary Key Not Null,
Audit_Description varchar(100),
Audit_Date Datetime,
Admin_ID int FOREIGN KEY  references Administrator(Admin_ID)not NULL
)
GO

CREATE TABLE ClientAudit_Log
(
Audit_ID int Identity (1,1) Primary Key Not Null,
Audit_Description varchar(100),
Audit_Date Datetime,
Client_ID int  FOREIGN KEY references Client(Client_ID)NULL,
)
GO


CREATE TABLE NotifyAdmin
(
Notify_ID int Identity (1,1) Primary Key Not Null,
Notify_Description varchar(100),
Notify_Date datetime,
Admin_ID int references Administrator(Admin_ID),
)
GO

CREATE TABLE OutPayment_Type
(
Out_ID int Identity (1,1) Primary Key Not Null,
Out_Description varchar (20)
)
GO
CREATE TABLE OutPayment
(
OutPayment_ID int Identity (1,1) Primary Key Not Null,
Out_Amount decimal,
Out_Paid bit,
Out_Date datetime,
Out_ID int references OutPayment_Type(Out_ID),
Client_ID int references Client(Client_ID)
)
GO

CREATE TABLE InPayment_Type
(
InType_ID int Identity (1,1) Primary Key Not Null,
InType_Description varchar (20)
)
GO

CREATE TABLE Rentals
(
Rental_ID int Identity (1,1) Primary Key Not Null,
Rental_Date datetime,
Client_ID int references Client(Client_ID)
)
GO

CREATE TABLE InPayment
(
In_ID int Identity (1,1) Primary Key Not Null,
InP_Amount Decimal,
InP_Paid bit,
InP_Date datetime,
Client_ID int references Client(Client_ID),
Rental_ID int references Rentals(Rental_ID),
Item_ID int references Item(Item_ID),
InType_ID int references InPayment_Type(InType_ID)
)
GO

CREATE TABLE Item_Questions
(
Item_Questions_ID int Identity (1,1) Primary Key Not Null,
Item_Question_Description varchar(200),
Item_Question_Answer varchar(100),
Item_Question_Date datetime,
Item_ID int references Item(Item_ID),
Client_ID int references Client(Client_ID)
)
GO
Create Table Rental_Status
(
Rental_Status int Identity (1,1) Primary Key Not Null,
Rental_Description varchar (30)
)
Go
CREATE TABLE Rented_Item
(
Rented_ID int Identity (1,1) Primary Key Not Null,
Rented_Start_Date datetime,
Rented_End_Date datetime,
Rent_Return_Date datetime,
Rent_Receipt_Date datetime,
Log_Date datetime,
Rental_Fee Decimal,
Rental_Deposit Decimal,
Extend_Rental Decimal,
Rental_Status_ID int references Rental_Status (Rental_Status),
Rental_ID int references Rentals(Rental_ID),
Item_ID int references Item(Item_ID)
)
GO
CREATE TABLE Complaint
(
Complaint_ID int Identity (1,1) Primary Key Not Null,
Complaint_reference varchar(10),
Complaint_Nature varchar(20),
Complaint_Description varchar(800),
Complaint_Resolved bit,
Date_Complaint datetime not null,
Date_Resolved datetime,
Complaint_Resolution_Description varchar(100),
Client_ID int references Client(Client_ID),
Rented_ID int references Rented_Item(Rented_ID)
)
GO

CREATE TABLE Client_Rating
(
Client_Rate_ID int Identity (1,1) Primary Key Not Null,
Rate_Level Int,
Rate_Comment varchar(100),
Rate_Date datetime,
Client_ID int references Client(Client_ID), ----Who is rating the client
Rented_ID int references Rented_Item(Rented_ID)
)
GO
CREATE TABLE Contracts
(
Contract_ID int Identity (1,1) Primary Key Not Null,
Contract_Description varchar (8000),
Rental_ID int references Rentals(Rental_ID)
)
GO

CREATE TABLE Late_Rentals
(
Late_ID int Identity (1,1) Primary Key Not Null,
Late_Period int,---Calculation of how many days it was late
Late_Fine Decimal,----Calculated Fine
Rate_ID int references Charge_Rate(Rate_ID),
Rented_ID int references Rented_Item(Rented_ID)
)
GO

CREATE TABLE Item_Ratings
(
Ratings_ID int Identity (1,1) Primary Key Not Null,
Ratings_Level Int,
Rating_Comment varchar(150),
Ratings_date date,
Rented_ID int references Rented_Item(Rented_ID)
)
GO

Create Table Terms_Conditions
(
Terms_ID int Identity (1,1) Primary Key Not Null,
Terms_Name varchar(100),
Terms_Description varchar(8000)
)

GO

----------------------------------INSERT INTO------------------------------------------
--Insert into User_Access
INSERT INTO User_Access values ('Owner')
INSERT INTO User_Access values ('Admin')
INSERT INTO User_Access values ('Client')
Go


-- Insert into Province
INSERT INTO Province  values ('Gauteng')
INSERT INTO Province  values ('Free State')
INSERT INTO Province  values ('North West')
INSERT INTO Province  values ('Limpopo')
INSERT INTO Province  values ('Western Cape')
INSERT INTO Province  values ('Eastern Cape')
INSERT INTO Province  values ('Nothern Cape')
INSERT INTO Province  values ('Mphumalanga')
INSERT INTO Province  values ('KwaZulu-Natal')
Go

-- Insert into City

INSERT INTO City  values ('Johannesburg',1)
INSERT INTO City  values ('Pretoria',1)
INSERT INTO City  values ('Krugersdorp',1)
INSERT INTO City  values ('Welkom',2)
INSERT INTO City  values ('Potchefstroom',3)
INSERT INTO City   values ('Klerksdorp',3)
INSERT INTO City   values ('Polokwane',4)
INSERT INTO City   values ('Tzaneen',4)
INSERT INTO City   values ('Cape Town',5)
INSERT INTO City   values ('Paarl',5)
INSERT INTO City   values ('East London',6)
INSERT INTO City   values ('Port Elizabeth',6)
INSERT INTO City   values ('Kimberley',7)
INSERT INTO City   values ('Mhluzi',8)
INSERT INTO City   values ('Msunduzi',8)
INSERT INTO City   values ('Durban',9)
Go

---Insert into Subrub Table
Insert into Suburb values ('Sandton',1)
Insert Into Suburb values('Hatfield',2)
insert into Suburb values('Waterkloof',2)
insert into Suburb values('Silverfields',3)
insert into Suburb values('Lakeview',4)
insert into Suburb values('Ikageng',5)
insert into Suburb values('Manzil Park',6)
insert Into Suburb values('Madiba Park',7)
insert Into Suburb values('Ivy Park',7)
insert into Suburb values('Riverside',8)
insert into Suburb values('Greenpoint',9)
insert into Suburb values('Seapoint',9)
insert Into Suburb values('Riverside',10)
insert into Suburb values('Mdatsane',11)
insert into Suburb values('South Ridge',13)
insert into Suburb values('Hillside',14)
Insert Into Suburb values('LadySmith',16)
 go
----Insert into Category

INSERT INTO Category values('Garden')
INSERT INTO Category values('Cars')
insert into Category values('Electronics')
insert into Category values('Decor')
insert into Category values('Sports Equipment')
insert into Category values('Leisure')
insert into Category values('Gardening')
INSERT INTO Category values('Bridal Wear')
INSERT INTO Category values('Cleaning Equipment')
insert into Category values('Boats')
insert into Category values('Holiday Homes')
insert into Category values('Office Stationery')
insert into Category values('Training Equipment')
insert into Category values('Beauty')
insert into Category values('Other')
go
----Insert Into Default Image
INSERT Into Default_Image values('Item Image','\Images\default.jpg')
Insert into Default_Image values('Client Image', '\Images\Default Item Image.jpg')
go

---Insert into Image status
insert into Image_Status values('Enabled')
insert into Image_Status values('Blocked')
go 

---Insert into Security questions
Insert into Security_Questions values('What is your mother’s maiden name')
Insert Into Security_Questions Values ('What is your mothers maiden surname?')
Insert Into Security_Questions Values ('What was the name of your first pet?')
Insert Into Security_Questions Values ('Where were you born?')
insert into Security_Questions values('What is the name of the first Primary School you went to?')
insert into Security_Questions values('What is the name of the first High School you went to?')
insert into Security_Questions values('What was your first nicknname?')
insert into Security_Questions values('What is your grandmother’s first name?')
insert into Security_Questions values('What is your grandfather’s first name?')
Insert into Security_Questions values('What is the first movie you ever watched?')
Insert Into Security_Questions Values ('What was he name of your first grade teacher?')
Insert Into Security_Questions Values ('Who was your date for your matric dance?')
Insert Into Security_Questions Values ('What was the name of your first pet?') 
insert into Security_Questions values('What is the middle name of your oldest child?')
insert into Security_Questions values('What was the name of your first stuffed animal?')
Go

---Insert into gender
Insert Into Gender Values ('Female')
Insert Into Gender Values ('Male')
Go


---Insert into Client status
insert into User_Status values('Active')
insert into User_Status values('Deactivated')
insert into User_Status values('Blocked')
Go


---Insert into Client
INSERT INTO Client values('Carmen','Jeppe','5761 SectionQ, Sekhukhune Street,MamelodiWest,Pretoria,0122','0725624444','01236748','0128053629','carmenjeppe@yahoo.com','carmenjeppe','89:5','','carmenjeppe@yahoo.com','','','9064890849489','','',0,'',0,1,4.00,'Peter','Jeppe','0827269985','','peterjeppe@gmail.com','2009-06-21 08:42:33',1,3,1,1,1,1)
INSERT INTO Client values('Joan','Serah','Flat 123 Burnett Villa,Burnett Street,Hatfield,Pretoria,0083','0795586425','012597745','0123635263','serah.joan@gmail.com','joan','nser5678','','serah.joan@gmail.com','','','9001311234058','','',0,'',0,1,5.00,'Precious','Peters','0825269985','','ppeters@gmail.com','2009-05-21 09:42:33',1,3,1,8,1,1)
INSERT INTO Client values('Leah','Louw','123 Lake street,,Ikageng,Potchefstroom,2531','0761231245','012597745','0123635263','leahlouw@gmail.com','serah','pivexs','','serahjoan','','','8907210831125','','',1,'',1,1,5.00,'Joan','Arch','0821269985','','arch.joan@gmail.com','2009-07-21 19:07:33',1,3,2,3,2,1)
INSERT INTO Client values('Donald','Duck','111 Festival Street,,Hatfield,Pretoria,0122','0789969696','0123363358','0125589697','donald.duck@yahoo.com','f.fischer','1234','Mark','donald','','','9006048908494','','',0,'',0,1,3.00,'Chantell','Chwabe','0825269985','','cchwabe@gmail.com','2009-07-21 10:42:33',1,3,1,1,3,2)
INSERT INTO Client values('Kerri','Fischer','1024 New Heights,Church Street,Sunnyside,Pretoria,0081','0825569693','012597745','0123635263','kerri.fischer@yahoo.com','joan','nser5678','','Joan2tuks','','','7309011234789','','',0,'',0,1,2.00,'Jacques','Callis','0825269985','','Callisj@gmail.com','2012-07-29 13:49:33',1,3,1,8,1,1)
INSERT INTO Client values('Thembi','Nkosi','50 Sekhute street,,Silverlakes,Pretoria,2531','0812993365','012597745','0123635263','thembinkosi@gmail.com','lera','pivexs','','thembinkosi@gmail.com','','','8201031256336','','',1,'',1,1,4.00,'Jack','Reed','0825269985','','jack.reed@gmail.com','2009-07-21 13:42:33',1,3,1,5,1,1)
INSERT INTO Client values('Cecil','Rhodes','5761 Church Tower, Church Street,Sunnyside,Pretoria,0122','0725624921','01236748','0128053629','CecilR@yahoo.com','nelza','89:5','','CecilR@yahoo.com','','','9064890849489','','',0,'',0,1,3.00,'Lindiwe','Sisulu','0825269985','','sisululindi@gmail.com','2009-07-21 11:22:33',1,3,2,5,1,2)
INSERT INTO Client values('Phineas','Serah','Flat 5 Schoeman Villa,Schoeman Street,Hatfield,Pretoria,0083','072569655','012597745','0123635263','Phineas@gmail.com','joan','Phineas@gmail.com','','Joan2tuks','','','7301091125789','','',0,'',0,1,5.00,'Leana','Norman','0825269985','','lnorman@gmail.com','2008-07-6 13:42:33',1,3,1,11,2,2)
INSERT INTO Client values('Ferb','Serah','50 Sebakwane street,,Ikageng,Potchefstroom,2531','082597745','012569655','0123635263','FerbSplits@gmail.com','lera','pivexs','','FerbSplits@gmail.com','','','2222222222222','','',1,'',1,1,5.00,'Joan','Mwenda','0825269985','','mwenda.joan@gmail.com','2009-07-21 13:42:33',1,3,1,1,1,2)
INSERT INTO Client values('Dorah','Explorer','57 South Boulevard, South Street,Hatfield,Pretoria,0122','0712223344','01236748','0128053629','Explorer@yahoo.com','nelza','89:5','','Explorer@yahoo.com','','','9005260478023','','',0,'',0,1,4.00,'Lerato','Khumisi','0825269985','','leratokhumisi@gmail.com','2009-05-02 13:42:33',1,3,2,3,1,1)
INSERT INTO Client values('Humpty','Dumpty','Flat 123 Burnett Villa,Burnett Street,Hatfield,Pretoria,0083','0712398858','012597745','0123635263','Dumpty.Humpty@gmail.com','joan','nser5678','','Dumpty.Humpty@gmail.com','','','8907070123456','','',0,'',0,1,5.00,'Phindile','Nolte','0825269985','','pnolte@gmail.com','2012-07-21 13:42:33',1,3,2,1,1,2)
INSERT INTO Client values('John','Pierre','50 Sebakwane street,,Ikageng,Potchefstroom,2531','072569655','012597745','0123635263','Pierrej@gmail.com','lera','pivexs','','Pierrej@gmail.com','','','2222222222222','','',1,'',1,1,5.00,'Joan','Mwenda','0825269985','','mwenda.joan@gmail.com','2009-07-21 13:42:33',1,3,1,1,1,2)
INSERT INTO Client values('Adelaide','Timpane','5761 SectionQ, Sekhukhune Street,MamelodiWest,Pretoria,0122','0725624921','01236748','0128053629','ATimpane@yahoo.com','nelza','89:5','','ATimpane@yahoo.com','','','9002089084948','','',0,'',0,1,3.00,'Lerato','Khumisi','0825269985','','lkhumisi@gmail.com','2009-07-21 13:42:33',1,3,1,12,2,1)
INSERT INTO Client values('Louis','Lane','Flat 05 Cum Laude,South Street,Hatfield,Pretoria,0083','0787896655','012597745','0123635263','louis.lane@gmail.com','louis','nser5678','','louis.lane@gmail.com','','','7201260374089','','',0,'',0,1,2.00,'Clark','Kent','0825269985','','ckent@gmail.com','2010-07-21 13:42:33',1,3,2,11,1,1)
INSERT INTO Client values('Mark','Diesel','50 Lakeview street,,Miederpark,Potchefstroom,2531','012569655','0711597745','0123635263','mark.diesel@gmail.com','mark','pivexs','','mark.diesel@gmail.com','','','6809260374085','','',1,'',1,1,1.00,'Larry','Diesel','0825269985','','larry.diesel@gmail.com','2011-07-21 13:42:33',1,3,1,1,1,2)

GO

---Insert into Item Status
insert into Item_Status values('Available')
insert into Item_Status values('Unavailable')
insert into Item_Status values('Deactivated')
GO

INSERT into Item values('Laptop','Black 4GB RAM i5 Core Processor',500.00,'Laptop.jpg','\Images\Laptop','5761 SectionQ, Sekhukhune Street','2009-07-21 13:42:33','',1000.00,500.00,150.00,0,0,'',0,'',0,'',3,1,1,2,1,3)
INSERT into Item values('Computer','Black 2GB RAM i3 Core Processor, Graphics Card',250.00,'Computer.jpg','\Images\Computer','Flat 123 Burnett Villa,Burnett Street','2009-07-21 13:50:28','',800.00,450.00,50.00,0,0,'',0,'',0,'',3,1,2,1,6,1)
INSERT into Item values('LawnMower','Green 1995 Model',250.00,'Lawnmower.jpg','\Images\Lawnmower','Flat 123 Burnett Villa,Burnett Street','2009-07-21 13:42:33','',750.00,300.00,70.00,0,0,'2011-11-22 14:03:23',0,'',0,'',1,1,2,1,8,1)
INSERT into Item values('BMW 3 Series','Black ',1500.00,'3series.jpg','\Images\3series','5761 SectionQ, Sekhukhune Street','2009-07-21 13:42:33','',5000.00,1250.00,150.00,0,0,'',0,'',0,'',2,1,1,2,2,3)
INSERT into Item values('IPAD','Green 1995 Model',500.00,'iPad.jpg','\Images\iPad','Flat 123 Burnett Villa,Burnett Street','2009-09-23 14:51:33','',800.00,300.00,100.00,0,0,'',0,'',0,'',3,1,2,1,6,1)
INSERT into Item values('Tableturner','3 Disc Model',250.00,'Tableturner.jpg','\Images\Tableturner','Flat 123 Burnett Villa,Burnett Street','2011-06-25 12:49:31','',800.00,600.00,120.00,0,0,'2011-03-25 13:42:33',0,'',0,'',3,1,4,1,8,1)
INSERT into Item values('Chess Set','Glass',250.00,'ChessSet.jpg','\Images\ChessSet','5761 SectionQ Sekhukhune Street','2011-02-21 13:42:33','',400.00,200.00,50.00,0,0,'2012-08-21 13:42:33',0,'',0,'',6,1,1,2,2,2)
INSERT into Item values('Pool Table','Green 1995 Model',350.00,'Pool_Table.jpg','\Images\Pool_Table','1024 New Heights','2009-07-21 13:42:33','',700.00,400.00,100.00,0,0,'2012-08-21 13:42:33',1,'',0,'',6,1,5,1,6,1)
INSERT into Item values('Jumping Castle','Gladiator',150.00,'Jumping_CastleG.jpg','\Images\Jumping_CastleG','50 Sekhute street','2009-07-21 13:42:33','',500.00,300.00,150.00,0,0,'2011-07-21 13:42:33',0,'',0,'',6,1,6,1,4,1)
INSERT into Item values('Jumping Castle','Slip and Slide',200.00,'Jumping_CastleG.jpg','\Images\Jumping_CastleG','50 Sekhute street','2009-06-21 13:42:33','',500.00,300.00,150,0,0,'',0,'',0,'',6,1,8,2,1,2)
INSERT into Item values('Tent','Green 1995 Model',200.00,'Tent.jpg','\Images\Tent','57 South Boulevard, South Street','2009-07-21 13:42:33','',300.00,200,100.00,0,0,'2012-09-26 13:11:33',0,'Outdoor',0,'',15,1,10,1,2,1)
INSERT into Item values('Cricket Set','Kids Age 3 - 7',100.00,'Cricket_Set.jpg','\Images\Cricket_Set','123 Lake street','2009-07-21 13:42:33','',500.00,300.00,150.00,0,0,'2011-04-02 11:42:33',0,'',0,'',6,1,3,1,5,1)
INSERT into Item values('Ink Jet Printer','Black',550.00,'Printer.jpg','\Images\Printer','111 Festival Street','2009-07-21 13:42:33','',800.00,600.00,200,0,0,'2009-07-21 13:42:33',0,'',0,'',12,1,4,2,1,1)
INSERT into Item values('Pop Corn Machine','Green 1995 Model',350.00,'popcornmachine.jpg','\Images\popcornmachine','1024 New Heights,Church Street','2012-03-23 22:50:00','',600.00,200.00,50.00,0,0,'2009-07-21 13:42:33',0,'Cooking',0,'',15,1,5,1,5,1)
INSERT into Item values('Carpet and Couch Machine','Green 1995 Model',200.00,'Cleaner.jpg','\Images\Cleaner','123 Lake street','2011-07-03 16:42:33','',500.00,300.00,70.00,0,0,'',0,'',0,'',9,1,3,1,3,1)
INSERT into Item values('Christmas Lights','5 Meters',250.00,'Christmaslights.jpg','\Images\Christmaslights','123 Lake street','2012-08-21 15:42:33','',300.00,300.00,100.00,0,0,'',0,'',0,'',4,1,3,1,3,1)
GO

insert into Charge_Rate values('Late Return',10)
insert into Charge_Rate values('Damaged Item',15)
Go


---Insert into Reported images
Insert into Reported_Images values ('Inappropriate image','2009-07-21 13:42:33',2,1)
Insert into Reported_Images values ('Offensive to my religeon','2010-07-21 13:42:33',1,2)
Insert into Reported_Images values ('Pornographic material','2011-01-21 13:42:33',3,6)
Insert into Reported_Images values ('Offensive to my religeon','2010-12-21 13:42:33',3,15)
Insert into Reported_Images values ('Removes Images when the item has been rented','2011-03-21 13:42:33',3,14)
Insert into Reported_Images values ('Inappropriate image','2009-07-21 13:42:33',2,1)
Insert into Reported_Images values ('Offensive to my religeon','2010-07-21 13:42:33',1,2)
Insert into Reported_Images values ('Pornographic material','2011-01-21 13:42:33',3,6)
Insert into Reported_Images values ('Offensive to my religeon','2010-12-21 13:42:33',3,15)
Insert into Reported_Images values ('Removes Images when the item has been rented','2011-03-21 13:42:33',3,14)
Insert into Reported_Images values ('Inappropriate image','2009-07-21 13:42:33',2,1)
Insert into Reported_Images values ('Offensive to my religeon','2010-07-21 13:42:33',1,2)
Insert into Reported_Images values ('Pornographic material','2011-01-21 13:42:33',3,6)
Insert into Reported_Images values ('Offensive to my religeon','2010-12-21 13:42:33',3,15)
Insert into Reported_Images values ('Removes Images when the item has been rented','2011-03-21 13:42:33',3,14)
Go

---Insert into Notification
insert into Notifications values('Client Details','2009-07-21 13:42:33',1)
insert into Notifications values('Returned Item','2009-07-21 13:42:33',1)
insert into Notifications values('Received Item','2009-07-21 13:42:33',1)
insert into Notifications values('Client Verification','2009-07-21 13:42:33',2)
insert into Notifications values('Blocked Client','2009-07-21 13:42:33',5)
insert into Notifications values('Client Details','2009-07-21 13:42:33',3)
insert into Notifications values('Changed Category Name','2009-07-21 13:42:33',1)
insert into Notifications values('Item Blocked','2009-07-21 13:42:33',6)
insert into Notifications values('Client Details','2009-07-21 13:42:33',1)
insert into Notifications values('Returned Item','2009-07-21 13:42:33',1)
insert into Notifications values('Client Verification','2009-07-21 13:42:33',2)
insert into Notifications values('Blocked Client','2009-07-21 13:42:33',5)
insert into Notifications values('Client Details','2009-07-21 13:42:33',3)
insert into Notifications values('Changed Category Name','2009-07-21 13:42:33',1)
insert into Notifications values('Item Blocked','2009-07-21 13:42:33',6)
Go

---Insert into Administrator
INSERT INTO Administrator Values ('Mr','Jaco','Van Den Heerven','owner','owner1234','0127785969','0785569693','2 Lynwood Road,Pretoria','8712120036487','5855','socialhire.2012@gmail.com','Jaco',1,1,2,1)
INSERT INTO Administrator Values ('Mr','Richard','Cruise','richardcruise','admin1234','0125586696','0745896963','2 Lynwood Road,Pretoria','8712120036023','8927','socialhire.2012@gmail.com','John',2,1,2,2)
INSERT INTO Administrator Values ('Miss','Jane','Doe','JaneDoe','Jane1234','012562492','0714458296','2 Lynwood Road,Pretoria','8712120036487','5855','socialhire.2012@gmail.com','Jaco',2,1,2,1)
INSERT INTO Administrator Values ('Mr','John','Doe','JohnDoe','John1234','012562492','0723358969','2 Lynwood Road,Pretoria','8712120036487','5855','socialhire.2012@gmail.com','Jaco',2,1,2,1)
Go
 

---Insert into admin Audit Log
INSERT INTO AdminAudit_Log values ('Create an Administrator Account','2009-01-01 13:42:33',1)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-01-01 13:42:33',2)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-01-21 13:42:33',2)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-02-28 13:42:33',2)
INSERT INTO AdminAudit_Log values ('Deactivated account - Richard Cruise','2009-12-31 13:42:33',1)
INSERT INTO AdminAudit_Log values ('Create an Administrator Account','2010-01-01 14:42:33',1)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-01-01 13:42:33',3)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-01-21 13:42:33',3)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2009-02-28 13:42:33',3)
INSERT INTO AdminAudit_Log values ('Deactivated account - Jane Doe','2010-12-31 13:42:33',1)
INSERT INTO AdminAudit_Log values ('Create an Administrator Account','2011-01-01 15:42:33',1)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2011-01-01 13:42:33',4)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2011-01-21 13:42:33',4)
INSERT INTO AdminAudit_Log values ('Maintain Administrator Information','2011-02-28 13:42:33',4)
INSERT INTO AdminAudit_Log values ('Deactivated account - John Doe','2011-12-31 13:42:33',1)
GO

--insert into client audit log
INSERT INTO ClientAudit_Log values ('Added an item','2009-07-21 13:42:33',2)
INSERT INTO ClientAudit_Log values ('Maintained client Information','2009-07-21 13:42:33',1)
INSERT INTO ClientAudit_Log values ('Changed Password','2012-03-21 13:42:33',3)
INSERT INTO ClientAudit_Log values ('Maintained client Information','2009-02-21 13:42:33',1)
INSERT INTO ClientAudit_Log values ('Changed Profile Image','2009-05-21 13:42:33',4)
INSERT INTO ClientAudit_Log values ('Changed item image','2012-03-21 13:42:33',3)
INSERT INTO ClientAudit_Log values ('Added an item','2010-03-21 13:42:33',2)
INSERT INTO ClientAudit_Log values ('Maintained client Information','2009-07-21 13:42:33',1)
INSERT INTO ClientAudit_Log values ('Change Password','2012-02-01 13:42:33',3)
INSERT INTO ClientAudit_Log values ('Asked an item question','2009-02-21 13:42:33',7)
INSERT INTO ClientAudit_Log values ('Changed Profile Image','2009-07-20 13:42:33',4)
INSERT INTO ClientAudit_Log values ('Changed item image','2012-10-12 13:42:33',1)
INSERT INTO ClientAudit_Log values ('Added an item','2010-09-01 13:42:33',2)
INSERT INTO ClientAudit_Log values ('Maintained client Information','2009-07-21 13:42:33',8)
INSERT INTO ClientAudit_Log values ('Changed Password','2012-03-21 13:42:33',5)
INSERT INTO ClientAudit_Log values ('Maintained client Information','2009-02-21 13:42:33',11)
INSERT INTO ClientAudit_Log values ('Changed Profile Image','2009-12-21 13:42:33',9)
INSERT INTO ClientAudit_Log values ('Deactivated Profile','2012-03-21 13:42:33',2)

---Insert into NotifyAdmin
INSERT INTO NotifyAdmin values ('An image has been reported','2009-07-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('An item has been returned','2011-03-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('A complaint has been lodged','2009-07-21 13:42:33',2)
INSERT INTO NotifyAdmin values ('An image has been reported','2010-02-03 13:42:33',1)
INSERT INTO NotifyAdmin values ('An item has been returned','2011-03-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('A complaint has been lodged','2009-01-02 13:42:33',2)
INSERT INTO NotifyAdmin values ('An image has been reported','2009-07-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('An item has been returned','2011-03-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('A complaint has been lodged','2009-07-21 13:42:33',2)
INSERT INTO NotifyAdmin values ('An image has been reported','2010-02-03 13:42:33',1)
INSERT INTO NotifyAdmin values ('An item has been returned','2011-03-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('A complaint has been lodged','2009-07-21 13:42:33',2)
INSERT INTO NotifyAdmin values ('An image has been reported','2010-02-03 13:42:33',1)
INSERT INTO NotifyAdmin values ('An item has been returned','2011-03-21 13:42:33',1)
INSERT INTO NotifyAdmin values ('A complaint has been lodged','2012-07-21 13:42:33',2)
go
---Insert into Outpayement type
INSERT INTO OutPayment_Type values ('Deposit')
INSERT INTO OutPayment_Type values ('Rental Fee')
 INSERT INTO OutPayment_Type values('Service Fee')
Insert into OutPayment_Type values ('Damaged Item')
Insert into OutPayment_Type VALUES ('Late Rental')
Insert into OutPayment_Type values ('Non-Receipt')
GO


INSERT INTO OutPayment values (500.00,0,'2009-05-03 13:10:01',1,1)
INSERT INTO OutPayment values (300.00,1,'2009-05-03 13:10:01',2,1)
INSERT INTO OutPayment values (750.00,0,'2009-06-01 15:00:01',1,2)
INSERT INTO OutPayment values (500.00,0,'2009-06-01 15:00:01',2,2)
INSERT INTO OutPayment values (500.00,1,'2009-05-03 08:15:01',1,3)
INSERT INTO OutPayment values (1200.00,0,'2009-05-03 08:15:01',2,3)
INSERT INTO OutPayment values (750.00,0,'2010-02-01 09:21:01',3,3)
INSERT INTO OutPayment values (1800.00,1,'2010-02-01 09:21:01',2,3)
INSERT INTO OutPayment values (500.00,0,'2011-05-03 13:10:01',1,1)
INSERT INTO OutPayment values (300.00,0,'2011-05-03 13:10:01',3,1)
INSERT INTO OutPayment values (750.00,0,'2012-06-01 15:00:01',1,2)
INSERT INTO OutPayment values (500.00,0,'2012-06-01 15:00:01',2,2)
INSERT INTO OutPayment values (500.00,0,'2013-05-03 08:15:01',1,3)
INSERT INTO OutPayment values (1200.00,1,'2013-05-03 08:15:01',3,3)
INSERT INTO OutPayment values (750.00,1,'2012-02-01 09:21:01',5,3)
INSERT INTO OutPayment values (1800.00,0,'2013-02-01 09:21:01',4,3)
Go

---Insert into Inpayment Type
 insert into InPayment_Type values('Deposit')
 insert into InPayment_Type values('Rental Fee')
 insert into InPayment_Type values('Extend_Rental_Fee')
GO


 ----Insert Into Rentals
Insert Into Rentals Values('2010-05-03 08:10:01',1)
Insert Into Rentals Values('2008-08-28 09:10:01',13)
Insert Into Rentals Values('2009-05-03 10:10:01',1)
Insert Into Rentals Values('2009-06-02 08:10:01',2)
Insert Into Rentals Values('2009-06-03 08:10:01',2)
Insert Into Rentals Values('2009-07-08 11:45:01',3)
Insert Into Rentals Values('2010-05-03 08:23:01',2)
Insert Into Rentals Values('2011-05-03 08:33:01',3)
Insert Into Rentals Values('2012-05-03 19:48:01',14)
Insert Into Rentals Values('2010-05-03 08:10:01',1)
Insert Into Rentals Values('2008-08-28 09:10:01',3)
Insert Into Rentals Values('2009-05-03 10:10:01',1)
Insert Into Rentals Values('2009-06-02 08:10:01',15)
Insert Into Rentals Values('2009-06-03 08:10:01',2)
Insert Into Rentals Values('2009-07-08 11:45:01',3)
Insert Into Rentals Values('2009-06-02 08:10:01',4)
Insert Into Rentals Values('2009-06-03 08:10:01',8)
Insert Into Rentals Values('2009-07-08 11:45:01',11)
Insert Into Rentals Values('2009-06-02 08:10:01',7)
Insert Into Rentals Values('2009-06-03 08:10:01',5)
Insert Into Rentals Values('2009-07-08 11:45:01',6)
Insert Into Rentals Values('2009-06-02 08:10:01',9)
Insert Into Rentals Values('2009-06-03 08:10:01',10)
Insert Into Rentals Values('2009-07-08 11:45:01',12)
go

----Insert Into Inpayment
Insert into InPayment values(100.00,1,'2009-05-03 08:10:01',1,1,1,1)
Insert into InPayment values(100.00,0,'2009-05-03 08:10:01',1,1,1,2)
Insert into InPayment values(100.00,0,'2009-05-03 08:10:01',1,1,1,3)
Insert into InPayment values(100.00,0,'2010-02-03 10:00:22',7,2,2,1)
Insert into InPayment values(100.00,0,'2010-02-03 10:00:22',7,2,2,2)
Insert into InPayment values(100.00,1,'2010-02-03 10:00:22',7,2,2,3)
Insert into InPayment values(100.00,0,'2012-03-01 11:15:11',3,5,3,1)
Insert into InPayment values(100.00,0,'2012-03-01 11:15:11',3,5,3,2)
Insert into InPayment values(100.00,1,'2012-03-01 11:15:11',3,5,3,3)
Insert into InPayment values(100.00,0,'2011-02-05 09:15:01',2,9,5,1)
Insert into InPayment values(100.00,0,'2011-02-05 09:15:01',2,9,5,2)
Insert into InPayment values(100.00,1,'2011-02-05 09:15:01',2,9,5,3)
Insert into InPayment values(100.00,0,'2012-02-28 10:10:10',9,11,7,1)
Insert into InPayment values(100.00,0,'2012-02-28 10:10:10',9,11,7,2)
Insert into InPayment values(100.00,0,'2012-02-28 10:10:10',9,11,7,3)
go 




----Insert into Item Questions
Insert Into Item_Questions values('What is the colour of the lawnmower?','Green.','2009-07-21 13:42:33',3,1)
Insert Into Item_Questions values('Does the laptop havea CD Drive?',Null,'2009-08-20 13:42:33',1,2)
Insert Into Item_Questions values('How old is the laptop?',Null,'2011-07-21 13:42:33',1,1)
Insert Into Item_Questions values('How long have you had the computer?','Three years.','2009-08-20 14:00:33',2,2)
Insert Into Item_Questions values('Does the car have leather seats?',Null,'2009-07-21 13:42:33',4,1)
Insert Into Item_Questions values('Does the laptop come with speakers?','No.','2009-08-20 13:42:33',1,2)
Insert Into Item_Questions values('What brand is the laptop?',Null,'2011-07-21 13:42:33',1,15)
Insert Into Item_Questions values('How old is the computer?',Null,'2009-08-20 14:00:33',2,13)
Insert Into Item_Questions values('How long have you have your BMW?',Null,'2009-07-21 13:42:33',4,14)
Insert Into Item_Questions values('Does the jumping castle come with a pump?',Null,'2009-08-20 13:42:33',9,8)
Insert Into Item_Questions values('Can you use water on the jumping castle - is it a slip and slide?','','2011-07-21 13:42:33',10,10)
Insert Into Item_Questions values('Is the monitor LCD, and flat?','Yes it is.','2009-08-20 14:00:33',2,9)
Insert Into Item_Questions values('How big is the lawnmower?',Null,'2009-07-21 13:42:33',3,11)
Insert Into Item_Questions values('Does the laptop come with a bag?',Null,'2009-08-20 13:42:33',1,12)
Insert Into Item_Questions values('Does the laptop have bluetooth enabled?',Null,'2011-07-21 13:42:33',1,11)
Insert Into Item_Questions values('What colour is the computer?',Null,'2009-08-20 14:00:33',2,12)
GO

---Insert into rental Status
Insert Into Rental_Status Values ('Awaiting Return Confirmation')
Insert Into Rental_Status Values ('Oustanding')
Insert Into Rental_Status Values ('Awaiting Receipt Confirmation')
Insert Into Rental_Status Values ('Returned')



----Insert into Rented_Item
INSERT INTO Rented_Item values('2012-05-21 13:42:33','2012-07-21 13:42:33','2012-07-21  13:42:33','2012-07-21  13:42:33','2009-07-21 13:42:33',100.00,20.00,10.00,1,1,1)
INSERT INTO Rented_Item values('2012-07-22 12:42:34','2012-07-21 13:42:33','2012-07-21  13:42:33','2012-07-21  13:42:33','2009-07-21 13:42:33',100.00,10.00,10.00,3,1,2)
INSERT INTO Rented_Item values('2012-05-21 11:42:33','2012-07-21 13:42:33','2012-07-21  13:42:33','2012-07-21  13:42:33','2009-07-21 13:42:33',100.00,20.00,10.00,2,2,3)
INSERT INTO Rented_Item values('2009-07-22 11:00:34','2009-08-21 13:42:33','2009-08-21 13:42:33','2009-08-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,120.00,2,2,4)
INSERT INTO Rented_Item values('2009-07-22 13:33:34','2009-06-06 13:42:33','2009-08-21 13:42:33','2009-08-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,10.00,3,1,5)
INSERT INTO Rented_Item values('2011-05-21 13:55:33','2011-07-21 13:42:33','2011-07-21 13:42:33','2011-07-21 13:42:33','2011-07-21 13:42:33',100.00,20.00,10.00,3,2,2)
INSERT INTO Rented_Item values('2010-07-22 13:21:34','2010-08-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,120.00,3,2,2)
INSERT INTO Rented_Item values('2010-07-22 13:42:34','2010-07-23 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,10.00,1,1,1)
INSERT INTO Rented_Item values('2009-05-21 22:42:33','2009-06-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,20.00,10.00,1,2,2)
INSERT INTO Rented_Item values('2012-07-22 21:42:34','2012-07-25 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,120.00,2,2,6)
INSERT INTO Rented_Item values('2013-02-01 22:42:34','2013-03-02 13:42:33',null,null,null,100.00,10.00,10.00,3,1,1)
INSERT INTO Rented_Item values('2013-02-21 10:42:33','2013-02-25 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,20.00,10.00,1,2,10)
INSERT INTO Rented_Item values('2012-11-01 09:42:34','2012-11-04 13:42:33',null,null,null,120.00,650.00,null,2,2,12)
INSERT INTO Rented_Item values('2012-07-22 21:42:34','2012-07-25 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,10.00,120.00,2,2,6)
INSERT INTO Rented_Item values('2013-02-01 22:42:34','2013-03-02 13:42:33',null,null,null,100.00,10.00,10.00,3,1,1)
INSERT INTO Rented_Item values('2013-02-21 10:42:33','2013-02-25 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33','2009-07-21 13:42:33',100.00,20.00,10.00,1,2,10)
GO

---Insert into Complaint
Insert Into Complaint Values ('R1223','Broken Laptop','When I received my laptop, the screen was broken',0,'2009-07-21 13:42:33','','',1,1)
Insert Into Complaint Values ('R1224','Wrong Specifications','When the wasing machine was delivered to me, it was not as advertised',0,'2010-07-03 13:42:33','','',1,2)
Insert Into Complaint Values ('R1225','Wrong size','The dress I wanted was size 12 but I got a size 10, it was too small and I didnt even wear it :(',0,'2011-02-21 13:42:33','','',2,3)
Insert Into Complaint Values ('R1226','Broken Laptop','When I received my laptop, the screen was broken',0,'2009-07-21 13:42:33','','',1,4)
Insert Into Complaint Values ('R1227','Wrong Specifications','When the wasing machine was delivered to me, it was not as advertised',0,'2009-07-21 13:42:33','','',1,1)
Insert Into Complaint Values ('R1228','Wrong size','The dress I wanted was size 8 but I got a size 10, it was too big and I didnt even wear it :(',0,'2012-01-21 13:42:33','','',2,2)
Insert Into Complaint Values ('R1229','Broken Laptop','When I received my laptop, the screen was broken',0,'2009-07-21 13:42:33','','',1,3)
Insert Into Complaint Values ('R1230','Wrong Specifications','When the wasing machine was delivered to me, it was not as advertised',0,'2009-07-21 13:42:33','','',1,4)
Insert Into Complaint Values ('R1231','Wrong size','The dress I wanted was size 6 but I got a size 10, it was too big and I didnt even wear it :(',0,'2012-07-21 13:42:33','','',2,1)
Insert Into Complaint Values ('R1232','Broken Laptop','When I received my laptop, the screen was broken',0,'2009-07-21 13:42:33','','',1,2)
Insert Into Complaint Values ('R1233','Wrong Specifications','When the wasing machine was delivered to me, it was not as advertised',0,'2013-02-21 13:42:33','','',1,3)
Insert Into Complaint Values ('R1234','Wrong size','The dress I wanted was size 8 but I got a size 10, it was too big and I didnt even wear it :(',0,'2013-02-24 13:42:33','','',2,4)
Insert Into Complaint Values ('R1235','Broken Laptop','When I received my laptop, the screen was broken',0,'2009-07-21 13:42:33','','',1,2)
Insert Into Complaint Values ('R1236','Wrong Specifications','When the wasing machine was delivered to me, it was not as advertised',0,'2013-02-21 13:42:33','','',1,3)
Insert Into Complaint Values ('R1237','Wrong size','The dress I wanted was size 8 but I got a size 10, it was too big and I didnt even wear it :(',0,'2012-02-28 13:42:33','','',2,4)
Go

----Insert into Client Ratings
Insert Into Client_Rating Values (3,'The service received from her was average, she was late for our appointment','2009-07-21 13:42:33',1,1)
Insert Into Client_Rating Values (5,'He was excellent, arrived on time and was super friendly','2009-07-21 13:42:33',1,2)
Insert Into Client_Rating Values (1,'He tried to rob me','2009-07-21 13:42:33',2,2)
Insert Into Client_Rating Values (3,'The service received from her was average, she was late for our appointment','2009-07-21 13:42:33',1,3)
Insert Into Client_Rating Values (5,'He was excellent, arrived on time and was super friendly','2009-07-21 13:42:33',1,4)
Insert Into Client_Rating Values (1,'He tried to rob me','2009-07-21 13:42:33',2,5)
Insert Into Client_Rating Values (4,'The service received from her was average, she was late for our appointment','2009-07-21 13:42:33',1,6)
Insert Into Client_Rating Values (5,'He was excellent, arrived on time and was super friendly','2009-07-21 13:42:33',1,7)
Insert Into Client_Rating Values (1,'He tried to rob me','2009-07-21 13:42:33',2,8)
Insert Into Client_Rating Values (4,'The service received from her was average, she was late for our appointment','2009-07-21 13:42:33',1,9)
Insert Into Client_Rating Values (5,'He was excellent, arrived on time and was super friendly','2009-07-21 13:42:33',1,10)
Insert Into Client_Rating Values (1,'He tried to rob me','2009-07-21 13:42:33',2,11)
Insert Into Client_Rating Values (4,'The service received from her was average, she was late for our appointment','2009-07-21 13:42:33',1,12)
Insert Into Client_Rating Values (5,'He was excellent, arrived on time and was super friendly','2009-07-21 13:42:33',1,13)
Insert Into Client_Rating Values (1,'He tried to rob me','2009-07-21 13:42:33',2,14)
Go

--Insert into Contracts
Insert Into Contracts Values ('Paypal',1)
Insert Into Contracts Values ('Agreement',1)
Insert Into Contracts Values ('Paypal',2)
Insert Into Contracts Values ('Agreement',2)
Insert Into Contracts Values ('Paypal',3)
Insert Into Contracts Values ('Agreement',3)
Insert Into Contracts Values ('Paypal',4)
Insert Into Contracts Values ('Agreement',4)
Insert Into Contracts Values ('Paypal',5)
Insert Into Contracts Values ('Agreement',5)
Insert Into Contracts Values ('Paypal',6)
Insert Into Contracts Values ('Agreement',6)
Insert Into Contracts Values ('Paypal',7)
Insert Into Contracts Values ('Agreement',7)
Insert Into Contracts Values ('Paypal',8)
Insert Into Contracts Values ('Agreement',8)
Insert Into Contracts Values ('Paypal',9)
Insert Into Contracts Values ('Agreement',9)
Insert Into Contracts Values ('Paypal',10)
Insert Into Contracts Values ('Agreement',10)
Insert Into Contracts Values ('Paypal',11)
Insert Into Contracts Values ('Agreement',11)
Insert Into Contracts Values ('Paypal',12)
Insert Into Contracts Values ('Agreement',12)
Insert Into Contracts Values ('Paypal',13)
Insert Into Contracts Values ('Agreement',13)
Insert Into Contracts Values ('Paypal',14)
Insert Into Contracts Values ('Agreement',14)
Insert Into Contracts Values ('Paypal',15)
Insert Into Contracts Values ('Agreement',15)
Go

---Insert into Late Rentals
insert into Late_Rentals values(7,100.00,1,1)
insert into Late_Rentals values(7,50.00,2,1)
insert into Late_Rentals values(7,100.00,2,1)
insert into Late_Rentals values(7,50.00,2,1)
GO

 ---Insert into Item Rating
Insert Into Item_Ratings values(5,'','2009-07-21 13:42:33',1)
Insert Into Item_Ratings values(1,'The item does not have the colour specified in the item Profile','2012-01-25 13:42:33',1)
Insert Into Item_Ratings values(2,'The item is faulty ','2012-12-05 13:42:33',1) 
Insert Into Item_Ratings Values (1,'The TV was broken','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (4,'The laptop lived up to my expectations :)','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (5,'The computer was great and everything that the owner promised and  more was there','2009-07-21 13:42:33',4)
Insert Into Item_Ratings values(5,'','2009-07-21 13:42:33',1)
Insert Into Item_Ratings values(1,'The item does not have the colour specified in the item Profile','2012-01-25 13:42:33',1)
Insert Into Item_Ratings values(2,'The item is faulty ','2012-12-05 13:42:33',1) 
Insert Into Item_Ratings Values (1,'The TV was broken','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (4,'The laptop lived up to my expectations :)','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (5,'The computer was great and everything that the owner promised and  more was there','2009-07-21 13:42:33',4)
Insert Into Item_Ratings Values (1,'The TV was broken','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (4,'The laptop lived up to my expectations :)','2009-07-21 13:42:33',1)
Insert Into Item_Ratings Values (5,'The computer was great and everything that the owner promised and  more was there','2009-07-21 13:42:33',4)
Go