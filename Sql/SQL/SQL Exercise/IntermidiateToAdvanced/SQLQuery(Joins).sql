--School database

SELECT * FROM Course
SELECT * FROM Person
SELECT * FROM Department
SELECT * FROM CourseInstructor
SELECT * FROM OnlineCourse

--QUESTION 1
SELECT FirstName,EnrollmentDate,CourseID,Grade FROM Person p INNER JOIN StudentGrade s on p.PersonID=s.StudentID  WHERE EnrollmentDate>'2004-08-31' ORDER BY CourseID


--QUESTION 2
SELECT c.CourseID,Title,d.Name,PersonID FROM ((Course c LEFT OUTER JOIN CourseInstructor i on c.CourseID=i.CourseID) LEFT OUTER JOIN Department d on c.DepartmentID=d.DepartmentID) WHERE PersonID IS NULL

--	QUSTION 3
SELECT o.CourseID,URL,Title,Credits FROM Course c RIGHT OUTER JOIN OnlineCourse o  on o.CourseID=c.CourseID WHERE Credits BETWEEN 3 AND 5
