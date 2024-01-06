CREATE TABLE Journals (
  journal_id VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(journal_id, 1, 2) = 'JN'),
  title VARCHAR(255),
  publisher VARCHAR(255),
  subject_area VARCHAR(255),
  total_copies INT(6),
  available_copies INT(6)
);

CREATE TABLE Magazines (
  magazine_id VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(magazine_id, 1, 2) = 'MG'),
  title VARCHAR(255),
  publisher VARCHAR(255),
  total_copies INT(6),
  available_copies INT(6)
);

CREATE TABLE Departments (
  dept_id INT(4) PRIMARY KEY,
  dept_name VARCHAR(255)
);

CREATE TABLE Books (
  book_id VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(book_id, 1, 2) = 'BK'),
  title VARCHAR(255),
  author VARCHAR(255),
  publisher VARCHAR(255),
  subject VARCHAR(255),
  dept_id INT(4),
  total_copies INT(6),
  available_copies INT(6),
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Students (
  student_id VARCHAR(6) PRIMARY KEY CHECK(SUBSTR(student_id, 1, 3) = 'REG'),
  student_name VARCHAR(255),
  roll_number VARCHAR(8), 
  dept_id INT(4),
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Issued_Books (
  issue_id INT(4) PRIMARY KEY,
  book_id VARCHAR(5),
  student_id VARCHAR(6),
  issue_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Departments (dept_id, dept_name)
VALUES
    (101, 'CSE'),
    (102, 'ECE'),
    (103, 'ME');

INSERT INTO Books (book_id, title, author, publisher, subject, dept_id, total_copies, available_copies)
VALUES
    ('BK001', 'OS Fundamentals', 'E.Navathe', 'J. B. Lippincott & Co.', 'Operating Systems', 101, 5, 3),
    ('BK002', 'Basic Linux', 'E.Navathe', 'J. B. Lippincott & Co.', 'Operating Systems', 101, 10, 10),
    ('BK003', 'Basics of Oracle DB', 'J. D. Salinger', 'Little, Brown and Company', 'DBMS', 101, 3, 2),
    ('BK004', 'Database System', 'E.Navathe', 'George Allen & Unwin', 'DBMS', 101, 3, 2),
    ('BK005', 'New Data Networks', 'Jane Austen', 'T. Egerton, Whitehall', 'Data Networks', 102, 6, 6),
    ('BK006', 'Direct Comms', 'E.Navathe', 'J. B. Lippincott & Co.', 'Data Networks', 102, 5, 3),
    ('BK007', 'Basic of Analog Signals', 'George Orwell', 'J. B. Lippincott & Co.', 'Analog Signals', 102, 10, 9),
    ('BK008', 'Statics and Dynamics', 'Mariam Brothers', 'Little, Brown and Company', 'Boral Mechanics', 103, 3, 2),
    ('BK009', 'Dynamics', 'Beer Johnston', 'George Allen & Unwin', 'Boral Mechanics', 103, 7, 7),
    ('BK010', 'Fluids', 'Jane Austen', 'George Allen & Unwin', 'Fluid Mechanics', 103, 6, 5);

INSERT INTO Journals (journal_id, title, publisher, subject_area, total_copies, available_copies)
VALUES
    ('JN001', 'Nature', 'Springer Nature', 'General Science', 15, 15),
    ('JN002', 'Science', 'American Association for the Advancement of Science', 'General Science', 20, 20),
    ('JN003', 'The Lancet', 'Elsevier', 'Medical', 8, 8),
    ('JN004', 'New England Journal of Medicine', 'Massachusetts Medical Society', 'Medical', 10, 10),
    ('JN005', 'Journal of Finance', 'Wiley-Blackwell', 'Finance', 5, 5);

INSERT INTO Magazines (magazine_id, title, publisher, total_copies, available_copies)
VALUES
    ('MG001', 'Time', 'Time Inc.', 12, 12),
    ('MG002', 'National Geographic', 'National Geographic Society', 9, 9),
    ('MG003', 'The Economist', 'The Economist Group', 15, 15),
    ('MG004', 'Vogue', 'Condé Nast', 6, 6),
    ('MG005', 'Wired', 'Condé Nast', 8, 8);

INSERT INTO Students (student_id, student_name, roll_number, dept_id)
VALUES
    ('REG001', 'Arindam Chatterje', 'CSB06001', 101),
    ('REG002', 'Prannoy Chakroborty', 'CSB06002', 101),
    ('REG003', 'Rahul Dey', 'ECB06001', 102),
    ('REG004', 'David Lee', 'ECB06002', 102),
    ('REG005', 'Satish Ray', 'MEB06001', 103);

INSERT INTO Issued_Books (issue_id, book_id, student_id, issue_date, return_date)
VALUES
    (1001, 'BK001', 'REG002', '2008-08-17', '2008-08-19'),
    (1002, 'BK006', 'REG004', '2008-08-17', '2008-08-19'),
    (1003, 'BK003', 'REG001', '2008-08-18', NULL),
    (1004, 'BK004', 'REG002', '2008-08-18', '2008-08-21'),
    (1005, 'BK004', 'REG001', '2008-08-19', NULL),
    (1006, 'BK008', 'REG005', '2008-08-19', '2008-08-22'),
    (1007, 'BK001', 'REG001', '2008-08-20', NULL),
    (1008, 'BK010', 'REG005', '2008-08-21', '2008-08-25'),
    (1009, 'BK006', 'REG003', '2008-08-21', NULL),
    (1010, 'BK002', 'REG001', '2008-08-23', '2008-08-28'),
    (1011, 'BK003', 'REG002', '2008-08-24', '2008-08-30'),
    (1012, 'BK005', 'REG003', '2008-08-25', '2008-08-30'),
    (1013, 'BK001', 'REG002', '2008-08-26', NULL),
    (1014, 'BK008', 'REG005', '2008-08-28', NULL),
    (1015, 'BK007', 'REG003', '2008-08-29', NULL),
    (1016, 'BK006', 'REG004', '2008-08-30', NULL),
    (1017, 'BK010', 'REG005', '2008-08-31', NULL);

SELECT DISTINCT b.title, ib.issue_date
FROM Books b 
JOIN Issued_Books ib
ON b.book_id = ib.book_id
WHERE ib.issue_date BETWEEN '2008-08-21' AND '2008-08-29';

SELECT author AS 'Author', COUNT(title) AS 'No_of_Books' 
FROM Books 
GROUP BY author;

SELECT publisher, COUNT(*) as No_of_Books
FROM Books
GROUP BY publisher
HAVING No_of_Books = (
    SELECT MAX(book_count)
    FROM (
        SELECT COUNT(*) AS book_count
        FROM Books
        GROUP BY publisher
    ) AS temp
);

SELECT SUM(total_copies) AS 'Total Books'
FROM Books;

SELECT COUNT(ib.book_id) AS 'Books issued'
FROM Issued_Books ib
JOIN Students st
ON ib.student_id = st.student_id
WHERE st.roll_number = 'CSB06001' AND ib.return_date IS NULL;

UPDATE Books
SET author = 'ABC'
WHERE book_id = 'BK003';
SELECT * FROM Books;

SELECT st.student_name 
FROM Students st
JOIN Issued_Books ib ON st.student_id = ib.student_id
JOIN Books bk ON bk.book_id = ib.book_id
WHERE bk.title = 'Database System' AND bk.author = 'E.Navathe' AND ib.return_date IS NULL;

SELECT dt.dept_name, COUNT(bk.book_id) AS 'total_books'
FROM Departments dt
JOIN Books bk
ON dt.dept_id = bk.dept_id
GROUP BY dt.dept_id;

SELECT title, subject
FROM Books
WHERE subject LIKE "%ora%";