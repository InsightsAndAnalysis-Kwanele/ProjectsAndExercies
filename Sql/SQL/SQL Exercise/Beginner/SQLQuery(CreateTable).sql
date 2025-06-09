--CREATING DATABASE PLAYETRANSFERE

CREATE TABLE CLUB
(
 Club_ID int Primary key Not null,
 Club_Name varchar(100) Not null,
 Coach varchar(100) Not Null,
 PlayersValue int ,
 Manager varchar(100) Not Null,
 ClubOwner varchar(100)
)
GO

CREATE TABLE AGENT
(
  Agent_ID int Primary key not null,
  Agent_Name varchar(100) not null,
  CellphoneNumber int,
  Agency varchar(55)
)
GO

CREATE TABLE PLAYER
(
  Player_ID int Primary key Not NULL,
  Name varchar(55) Not NUll,
  Surname varchar(55) not null,
  Club_ID int references CLUB(Club_ID)  ,
  Hometown varchar(300),
  Agent_ID int references  AGENT(Agent_ID) ,
  MarketPrice int not null
)
GO
