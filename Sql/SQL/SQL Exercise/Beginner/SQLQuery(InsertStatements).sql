INSERT INTO AGENT(Agent_ID,Agent_Name,CellphoneNumber,Agency)
VALUES(509823,'Fixer',0112834533,'BF Agency')
GO



INSERT INTO PLAYER(Player_ID,Name,Surname,Club_ID,Hometown,Agent_ID,MarketPrice)
VALUES(809373,'Sancho','Radrigo',170202,'Barcelona',509823,345000)
go

INSERT INTO CLUB(Club_ID,Club_Name,Coach,PlayersValue,Manager,ClubOwner)
VALUES ('170202','Barcelona','Sancho',700250000,'Xavi','Ramero')
GO

