-- mysql -u ritabrata -p 

SHOW DATABASES;
CREATE DATABASE assignment_1;
USE assignment_1;

CREATE TABLE EMP(Eno CHAR(2) PRIMARY KEY CHECK(SUBSTR(Eno, 1, 1) = 'E'), Ename VARCHAR(10) NOT NULL, City VARCHAR(10) CHECK(City IN ('Chennai', 'Kolkata', 'Delhi', 'Mumbai')), Salary INT(6), Dno INT(2) );
CREATE TABLE DEPT(Dno INT(2) PRIMARY KEY, DesDname VARCHAR(15));
ALTER TABLE EMP ADD FOREIGN KEY (Dno) REFERENCES DEPT(Dno);
CREATE TABLE PROJECT(Pno CHAR(2) CHECK(SUBSTR(Pno, 1, 1) = 'P'), Eno CHAR(2), PRIMARY KEY(Pno, Eno), FOREIGN KEY (Eno) REFERENCES EMP(Eno));

SELECT ROUND(AVG(Salary), 2) AS 'AVERAGE' FROM EMP;
SELECT Ename AS 'Employee Names' FROM EMP WHERE (Salary > 7000 AND Salary < 18000);
SELECT * FROM EMP WHERE(LENGTH(Ename) = 4 AND Ename LIKE 'AS%');
SELECT COUNT(EMP.Dno) AS 'Count', DesDname FROM EMP JOIN DEPT WHERE (EMP.Dno = DEPT.Dno) GROUP BY EMP.Dno;
SELECT (MAX(Salary) - MIN(Salary)) AS DIFFERENCE FROM EMP;

