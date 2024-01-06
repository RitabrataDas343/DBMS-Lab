SELECT s.Name, s.Address, a.List_of_Courses
FROM Student s
JOIN AcademicProgramme a ON s.Programme_Code = a.Programme_Code
JOIN Department d ON a.Department_Code = d.Department_Code
WHERE d.Department_Name = 'Computer Science';

SELECT COUNT(*) AS Number_of_Teachers
FROM Teacher
WHERE Department = (SELECT Department_Code
                    FROM Department
                    WHERE Department_Name = 'Computer Science');

SELECT List_of_Courses_Offered
FROM Department
WHERE Department_Name = 'Computer Science';

SELECT Semester, Name
FROM Student
WHERE Semester = 1;

WITH StudentGrades AS (
  SELECT Roll_Number, AVG(Grade) AS CGPA
  FROM Grades
  GROUP BY Roll_Number
)
SELECT Name, Address, sg.CGPA
FROM Student s
JOIN StudentGrades sg ON s.Roll_Number = sg.Roll_Number
WHERE sg.CGPA >= 8.5;


