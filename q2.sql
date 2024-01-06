CREATE TABLE Student (
  Roll_Number INT PRIMARY KEY,
  Name VARCHAR(255),
  Address VARCHAR(255),
  Semester INT,
  Programme_Code INT,
  FOREIGN KEY (Programme_Code) REFERENCES AcademicProgramme(Programme_Code)
);

CREATE TABLE AcademicProgramme (
  Programme_Code INT PRIMARY KEY,
  Programme_Name VARCHAR(255) UNIQUE,
  Duration INT,
  List_of_Courses VARCHAR(255),
  Department_Code INT,
  FOREIGN KEY (Department_Code) REFERENCES Department(Department_Code)
);

CREATE TABLE Department (
  Department_Code INT PRIMARY KEY,
  Department_Name VARCHAR(255) UNIQUE,
  HoD INT,
  List_of_Courses_Offered VARCHAR(255),
  FOREIGN KEY (HoD) REFERENCES Teacher(Employee_Code)
);

CREATE TABLE Teacher (
  Employee_Code INT PRIMARY KEY,
  Name VARCHAR(255),
  Department INT,
  Designation VARCHAR(255),
  FOREIGN KEY (Department) REFERENCES Department(Department_Code)
);

CREATE TABLE Course (
  Course_Number INT PRIMARY KEY,
  Title_of_the_Course VARCHAR(255),
  Credit_Allotted INT,
  Offering_Department INT,
  FOREIGN KEY (Offering_Department) REFERENCES Department(Department_Code)
);

CREATE TABLE Grades (
  Roll_Number INT,
  Course_Number INT,
  Semester INT,
  Grade INT,
  PRIMARY KEY (Roll_Number, Course_Number, Semester),
  FOREIGN KEY (Roll_Number) REFERENCES Student(Roll_Number),
  FOREIGN KEY (Course_Number) REFERENCES Course(Course_Number)
);

CREATE TABLE CoursesOffered (
  Department_Code INT,
  Course_Number INT,
  Semester INT,
  Teacher_Code INT,
  PRIMARY KEY (Department_Code, Course_Number, Semester),
  FOREIGN KEY (Department_Code) REFERENCES Department(Department_Code),
  FOREIGN KEY (Course_Number) REFERENCES Course(Course_Number),
  FOREIGN KEY (Teacher_Code) REFERENCES Teacher(Employee_Code)
);
