CREATE TABLE Doctors (
  Doctor_ID VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(Doctor_ID, 1, 2) = 'DC'),
  Doctor_Code VARCHAR(3),
  Doctor_Name VARCHAR(50),
  Specialization VARCHAR(50)
);

CREATE TABLE Patients (
  Patient_ID VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(Patient_ID, 1, 2) = "PT") ,
  Registration_Number VARCHAR(6) CHECK(SUBSTR(Registration_Number, 1, 3) = "REG"),
  Patient_Name VARCHAR(50),
  Patient_Surname VARCHAR(50),
  Age INT(2),
  Address VARCHAR(100),
  Gender VARCHAR(1) CHECK(Gender IN ('M', 'F')),
  Bed_Number VARCHAR(3),
  Registration_Date DATE,
  Referral VARCHAR(100),
  Refer_Doctor_ID VARCHAR(5),
  FOREIGN KEY (Refer_Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Lab_Tests (
  Test_ID VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(Test_ID, 1, 2) = "TS"),
  Test_Name VARCHAR(50),
  Test_Number VARCHAR(50),
  Test_Date DATE,
  Results VARCHAR(10) CHECK(Results IN ('Positive', 'Negative')),
  Referred_Doctor_ID VARCHAR(5),
  Patient_ID VARCHAR(5),
  FOREIGN KEY (Referred_Doctor_ID) REFERENCES Doctors(Doctor_ID),
  FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

CREATE TABLE Beds (
  Bed_ID VARCHAR(5) PRIMARY KEY CHECK(SUBSTR(Bed_ID, 1, 2) = "BD") ,
  Bed_Number VARCHAR(3),
  Ward_Number INT(2),
  Patient_ID VARCHAR(5),
  Status VARCHAR(20) CHECK(Status IN ('Alloted','Not Alloted')),
  FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- Insert into Doctors table
INSERT INTO Doctors (Doctor_ID, Doctor_Code, Doctor_Name, Specialization)
VALUES 
  ('DC001', 'ABC', 'Dr. Rupam Das', 'Cardiology'),
  ('DC002', 'DEF', 'Dr. Rahul Dey', 'Gynecology'),
  ('DC004', 'XYZ', 'Dr. Mike Das', 'Neurology');

-- Insert into Patients table

INSERT INTO Patients (Patient_ID, Registration_Number, Patient_Name, Patient_Surname, Age, Address, Gender, Bed_Number, Registration_Date, Referral, Refer_Doctor_ID)
VALUES 
  ('PT011', 'REG001', 'Subhrajit', 'Majhi', 51,'123 Main St, Kolkata', 'M', '123', '2022-01-02', NULL,'DC001'),
  ('PT013', 'REG002', 'Pallavi', 'Dey', 23, '456 Pine St, Kolkata', 'F', '102', '2022-02-03', 'Kolkata MC','DC002'),
  ('PT015', 'REG003', 'Romi', 'Laskar', 41, '789 Maple St, Kolkata', 'M', '245', '2022-03-03', NULL, 'DC004'),
  ('PT017', 'REG004', 'Subhallina', 'Ghosh', 65,'1010 Oak St, Kolkata', 'F', '386', '2022-04-04', NULL, 'DC001'),
  ('PT019', 'REG005', 'Suman', 'Dhara', 20, '1111 Elm St, Kolkata', 'M', '810', '2022-05-05', NULL, 'DC002'),
  ('PT021', 'REG006', 'Prannoy', 'Chakroborty', 52, '123 Main St, Kolkata', 'M', '275', '2022-06-01', NULL,'DC001'),
  ('PT023', 'REG007', 'Sunigdha', 'Dey', 33, '456 Pine St, Kolkata', 'F', '965', '2022-07-02','Burdwan MC','DC002'),
  ('PT025', 'REG008', 'Anurag', 'Sarkar', 52, '789 Maple St, Kolkata', 'M', '155', '2022-08-03', NULL, 'DC004'),
  ('PT027', 'REG009', 'Sankha', 'Pal', 12, '1010 Oak St, Kolkata', 'M', '448', '2022-09-04', NULL, 'DC004'),
  ('PT031', 'REG010', 'Poulami', 'Karmakar', 20, '1111 Elm St, Kolkata', 'F', '663', '2022-10-05', NULL, 'DC002');

-- Insert into Lab_Tests table
INSERT INTO Lab_Tests (Test_ID, Test_Name, Test_Number, Test_Date, Results, Referred_Doctor_ID, Patient_ID)
VALUES 
  ('TS001', 'Blood Test', 'B001', '2022-02-10', 'Positive', 'DC001', 'PT011'),
  ('TS002', 'Urine Test', 'U001', '2022-03-11', 'Negative', 'DC004', 'PT015'),
  ('TS003', 'X-Ray', 'X001', '2022-04-12', 'Positive', 'DC001', 'PT017'),
  ('TS004', 'CT Scan', 'C001', '2022-05-13', 'Negative', 'DC002', 'PT019'),
  ('TS005', 'MRI', 'M001', '2022-05-14', 'Positive', 'DC002', 'PT019'),
  ('TS006', 'X-Ray', 'X002', '2022-07-20', 'Positive', 'DC002', 'PT023'),
  ('TS007', 'MRI', 'M002', '2022-07-11', 'Negative', 'DC002', 'PT023'),
  ('TS008', 'Blood Test', 'B002', '2022-07-12', 'Positive', 'DC001', 'PT011');

-- Insert into Beds table
INSERT INTO Beds (Bed_ID, Bed_Number, Ward_Number, Patient_ID, Status)
VALUES 
  ('BD001', '102', 11, 'PT013', 'Alloted'),
  ('BD002', '123', 12, 'PT011', 'Alloted'),
  ('BD003', '155', 13, 'PT025', 'Alloted'),
  ('BD004', '245', 13, 'PT015', 'Alloted'),
  ('BD005', '275', 12, 'PT021', 'Alloted'),
  ('BD006', '386', 11, 'PT017', 'Alloted'),
  ('BD007', '432', 12, NULL, 'Not Alloted'),
  ('BD008', '448', 10, 'PT027', 'Alloted'),
  ('BD009', '456', 10, NULL, 'Not Alloted'),
  ('BD010', '561', 10, NULL, 'Not Alloted'),
  ('BD011', '663', 11, 'PT031', 'Alloted'),
  ('BD012', '722', 10, NULL, 'Not Alloted'),
  ('BD013', '810', 11, 'PT019', 'Alloted'),
  ('BD014', '895', 12, NULL, 'Not Alloted'),
  ('BD015', '965', 12, 'PT023', 'Alloted');


SELECT *
FROM Patients
WHERE Registration_Date BETWEEN '2022-07-20' AND '2022-08-20';

UPDATE Patients
SET Patient_Name = 'Ram'
WHERE Patient_ID = 'PT011'; 
SELECT * FROM Patients WHERE Patient_ID = 'PT011';

SELECT p.Patient_Name, l.Test_Date, l.Test_Name, l.Results
FROM Patients p 
JOIN Lab_Tests l 
ON p.Patient_ID = l.Patient_ID
WHERE l.Test_Date = '2022-07-20';

SELECT d.Doctor_Name, d.Doctor_Code, COUNT(*) AS 'No_of_Patients'
FROM Patients p
JOIN Doctors d 
ON p.Refer_Doctor_ID = d.Doctor_ID
WHERE d.Doctor_Code = 'ABC';

SELECT d.Doctor_Name, COUNT(*) AS 'No_of_Patients'
FROM Patients p
JOIN Doctors d 
ON p.Refer_Doctor_ID = d.Doctor_ID
GROUP BY d.Doctor_ID 
ORDER BY No_of_Patients DESC
LIMIT 1;

UPDATE Patients
SET Bed_Number = '456'
WHERE Patient_ID = 'PT023';
UPDATE Beds
SET Patient_ID = NULL, Status = 'Not Alloted'
WHERE Patient_ID = 'PT023';
UPDATE Beds
SET Patient_ID = 'PT023', Status = 'Alloted'
WHERE Bed_Number = '456';

UPDATE Beds
SET Patient_ID = NULL, Status = 'Not Alloted'
WHERE Bed_Number = '123';
UPDATE Patients
SET Bed_Number = NULL
WHERE Bed_Number = '123';

SELECT * 
FROM Beds
WHERE (Ward_Number = 10 AND Status = 'Not Alloted');

SELECT p.Patient_Name 
FROM Patients p 
JOIN Doctors d 
ON p.Refer_Doctor_ID = d.Doctor_ID
JOIN Beds b 
ON b.Patient_ID = p.Patient_ID
WHERE p.Gender = 'M' AND d.Doctor_Code = 'XYZ' AND b.Ward_Number = 13; 

SELECT *
FROM Patients p 
JOIN Doctors d 
ON p.Refer_Doctor_ID = d.Doctor_ID
WHERE p.Age > 50 AND d.Doctor_Name LIKE "%DAS%";