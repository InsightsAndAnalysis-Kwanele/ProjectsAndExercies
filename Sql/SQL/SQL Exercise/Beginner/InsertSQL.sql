--master database
INSERT INTO PUBLISHER(Publisher_Name)
VALUES( 'Doubleday')

INSERT INTO PUBLISHER(Publisher_Name)
VALUES( 'Faber & Faber')

INSERT INTO PUBLISHER(Publisher_Name)
VALUES( 'AuthorHouse')

INSERT INTO PUBLISHER(Publisher_Name)
VALUES( 'Park row')

INSERT INTO PUBLISHER(Publisher_Name)
VALUES( 'Houghton Mifflin')

INSERT INTO AUTHOR(AuthorName)
VALUES( 'Stephen King')

INSERT INTO AUTHOR(AuthorName)
VALUES( 'Sally Rooney')

INSERT INTO AUTHOR(AuthorName)
VALUES( 'Helen Phillips')


INSERT INTO AUTHOR(AuthorName)
VALUES( 'Mary
Kubica')


INSERT INTO AUTHOR(AuthorName)
VALUES( 'Philip Roth')


INSERT INTO BOOK(Book_Name,Book_Genre)
VALUES( 'The Stand','Dark Fantasy')

INSERT INTO BOOK(Book_Name,Book_Genre)
VALUES( 'Normal People','Romance')

INSERT INTO BOOK(Book_Name,Book_Genre)
VALUES( 'Fly With Me','Romance')

INSERT INTO BOOK(Book_Name,Book_Genre)
VALUES( 'Local woman missing','Thriller')

INSERT INTO BOOK(Book_Name,Book_Genre)
VALUES( 'Good bye Collombus','Short Stories')

INSERT INTO BOOKPUBLISHER(Release_Date)
VALUES('3 Oct 1978')

INSERT INTO BOOKPUBLISHER(Release_Date)
VALUES('28 Aug 2018')

INSERT INTO BOOKPUBLISHER(Release_Date)
VALUES('12 Sep 2009')

INSERT INTO BOOKPUBLISHER(Release_Date)
VALUES('18 May 2021')

INSERT INTO BOOKPUBLISHER(Release_Date)
VALUES('7 May 1959')

SELECT * FROM PUBLISHER
SELECT * FROM AUTHOR
SELECT * FROM BOOK
SELECT * FROM BOOKPUBLISHER

