CREATE TABLE Student(
    Roll_Number VARCHAR(6) PRIMARY KEY CHECK(SUBSTR(Roll_Number, 1, 3) = 'DGP'),
    Address VARCHAR(20),
    Name VARCHAR(20),
    Semester INT(3)
);

CREATE TABLE Programme(
    Programme_Code VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(Programme_Code, 1, 2) = 'AP'),
    Programme_Name VARCHAR(10),
    Duration INT(5)
);

CREATE TABLE Professor(
    Emp_Code VARCHAR(4) PRIMARY KEY CHECK(SUBSTR(Emp_Code, 1, 1) = 'P'),
    Designation VARCHAR(20),
    Name VARCHAR(20),
    Dept_Code VARCHAR(5)
);

CREATE TABLE Department(
    Dept_Code VARCHAR(5) PRIMARY KEY,
    Dept_Name VARCHAR(50),
    HOD_Code VARCHAR(4) CHECK(SUBSTR(HOD_Code, 1, 1) = 'P'),
    FOREIGN KEY(HOD_Code) REFERENCES Professor(Emp_Code)
);

CREATE TABLE Course(
    Course_No VARCHAR(4) PRIMARY KEY CHECK(SUBSTR(Course_No, 1, 1) = 'C'),
    Course_Title VARCHAR(20),
    Course_Credit INT(3),
    Offering_Dept VARCHAR(5),
    Programme_Code VARCHAR(5) CHECK(SUBSTR(Programme_Code, 1, 2) = 'AP'),
    FOREIGN KEY(Offering_Dept) REFERENCES Department(Dept_Code),
    FOREIGN KEY(Programme_Code) REFERENCES Programme(Programme_Code)
);

CREATE TABLE Registration(
    Roll_No VARCHAR(6) CHECK(SUBSTR(Roll_No, 1, 3) = 'DGP'),
    Course_No VARCHAR(4) CHECK(SUBSTR(Course_No, 1, 1) = 'C'),
    Semester INT(3),
    Grade FLOAT(3),
    FOREIGN KEY(Roll_No) REFERENCES Student(Roll_Number),
    FOREIGN KEY(Course_No) REFERENCES Course(Course_No)
);

CREATE TABLE Dept_Course(
    Dept_Code VARCHAR(5),
    Course_No VARCHAR(4) PRIMARY KEY CHECK(SUBSTR(Course_No, 1, 1) = 'C'),
    Semester INT(3),
    Prof_Code VARCHAR(4) CHECK(SUBSTR(Prof_Code, 1, 1) = 'P'),
    FOREIGN KEY(Dept_Code) REFERENCES Department(Dept_Code),
    FOREIGN KEY(Course_No) REFERENCES Course(Course_No),
    FOREIGN KEy(Prof_Code) REFERENCES Professor(Emp_Code)
);

INSERT INTO Student 
VALUES
    ('DGP001', 'Durgapur', 'Shruti', 1),
    ('DGP002', 'Mumbai', 'Anubhav', 3),
    ('DGP003', 'Kolkata', 'Anurag', 4),
    ('DGP004', 'Delhi', 'Abhishek', 2),
    ('DGP005', 'Chennai', 'Swarup', 2);

INSERT INTO Programme 
VALUES
    ('AP001', 'B. Tech', 4),
    ('AP002', 'MBA', 2),
    ('AP003', 'M. Tech', 3),
    ('AP004', 'MCA', 2);

INSERT INTO Professor
VALUES
    ('P001', 'Professor', 'Jyoti Mullick', 'CSE'),
    ('P002', 'Junior Professor', 'Subrata Nandi', 'BBA'),
    ('P003', 'Assistant Professor', 'Atanu Banerjee', 'CSE'),
    ('P004', 'Senior Professor', 'Parag Kumar Guha', 'BBA');

INSERT INTO Department 
VALUES
    ('CSE', 'Computer Science', 'P001'),
    ('BBA', 'Business and Accountancy', 'P002');

INSERT INTO Course 
VALUES
    ('C001', 'DSA', 4, 'CSE', 'AP001'),
    ('C002', 'COA', 2, 'CSE', 'AP004'),
    ('C003', 'DBMS', 3, 'CSE', 'AP003'),
    ('C004', 'DAA', 4, 'CSE', 'AP003'),
    ('C005', 'Statistics', 4, 'BBA', 'AP002'),
    ('C006', 'Accounts', 4, 'BBA', 'AP002');

INSERT INTO Registration 
VALUES 
    ('DGP001', 'C001', 1, 3.4),
    ('DGP002', 'C002', 2, 1.8),
    ('DGP003', 'C003', 3, 2.5),
    ('DGP004', 'C004', 4, 3.4),
    ('DGP003', 'C001', 1, 2.4),
    ('DGP002', 'C003', 2, 2.5),
    ('DGP003', 'C001', 3, 2.2),
    ('DGP004', 'C004', 4, 3.6),
    ('DGP005', 'C005', 3, 3.2),
    ('DGP005', 'C006', 4, 2.6);


INSERT INTO Dept_Course 
VALUES
    ('CSE', 'C001', 1, 'P001'),
    ('CSE', 'C002', 2, 'P001'),
    ('BBA', 'C005', 3, 'P002'),
    ('BBA', 'C006', 2, 'P004'),
    ('CSE', 'C003', 3, 'P003'),
    ('CSE', 'C004', 3, 'P003');


select * from Student;
select * from Programme;
select * from Professor;
select * from Department;
select * from Course;
select * from Registration;
select * from Dept_Course;


-- a
SELECT s.Name, s.Address, c.Course_Title 
FROM Student s 
JOIN Registration r 
ON s.Roll_Number = r.Roll_No 
JOIN Course c 
ON r.Course_no = c.Course_no 
JOIN Dept_Course dco 
ON c.Course_no = dco.Course_no 
WHERE dco.Dept_Code = 'CSE';  

-- b
SELECT Dept_Code, COUNT(*) AS 'Total Faculty'
FROM Professor
WHERE Dept_Code = 'CSE';

-- c
SELECT c.Course_No, c.Course_Title, c.Course_Credit
FROM Course c JOIN Dept_Course dco
ON c.Course_No = dco.Course_No
WHERE dco.Dept_Code = 'CSE';

-- d
SELECT Semester, GROUP_CONCAT(Name) AS 'Students'
FROM Student
GROUP BY Semester;

-- e
SELECT s.Name, s.Roll_Number, ROUND(SUM(r.Grade)/SUM(c.Course_Credit)*10, 2) AS CGPA
FROM Student s 
JOIN Registration r
ON s.Roll_Number = r.Roll_No
JOIN Course c 
ON r.Course_No = c.Course_No
GROUP BY s.Roll_Number
HAVING CGPA >= 8.5;

-- a
SELECT s.Name, s.Roll_Number, s.Semester, COUNT(r.Course_No) AS Registered
FROM Student s 
JOIN Registration r
ON s.Roll_Number = r.Roll_No
GROUP BY s.Name, s.Roll_Number, s.Semester;

WITH Temp AS (
    SELECT s.Name, s.Roll_Number, r.Course_No, c.Programme_Code
    FROM Student s 
    JOIN Registration r
    ON s.Roll_Number = r.Roll_No
    JOIN Course c 
    ON r.Course_No = c.Course_No
    JOIN Programme p 
    ON c.Programme_Code = p.Programme_Code
)
SELECT s1.Name, s1.Roll_Number
FROM Temp s1, Temp s2
WHERE s1.Roll_number = s2.Roll_number AND s1.Programme_Code = 'AP004' AND s2.Programme_Code = 'AP003';

SELECT c.Course_Title, COUNT(DISTINCT r.Roll_No) as 'Total Enrolled'
FROM Registration r
JOIN Course c 
ON r.Course_No = c.Course_No
WHERE c.Course_Title = "DBMS";

SELECT DISTINCT s.Semester
FROM Student s 
JOIN Registration r 
ON s.Roll_Number = r.Roll_No
JOIN Course c 
ON r.Course_No = c.Course_No
WHERE c.Course_Title = "DBMS";

SELECT Name 
FROM Student
ORDER BY Name;