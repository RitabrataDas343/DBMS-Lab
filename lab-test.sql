CREATE TABLE doctors(
    doctor_id VARCHAR(6) PRIMARY KEY CHECK(SUBSTR(doctor_id, 1, 2) = "DC"),
    doctor_name VARCHAR(255) NOT NULL,
    doctor_age INT(6) NOT NULL,
    doctor_gender VARCHAR(20) NOT NULL CHECK(doctor_gender IN ('Male', 'Female')),
    speciality VARCHAR(255) NOT NULL
);

CREATE TABLE patients(
    patient_id VARCHAR(6) PRIMARY KEY CHECK(SUBSTR(patient_id, 1, 2) = "PT"),
    patient_name VARCHAR(255) NOT NULL,
    patient_age INT(6) NOT NULL,
    patient_gender VARCHAR(20) NOT NULL CHECK(patient_gender IN ('Male', 'Female')),
    doctor_id VARCHAR(6) NOT NULL CHECK(SUBSTR(doctor_id, 1, 2) = "DC"),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO doctors
VALUES 
    ('DC001', 'Atanu Bepari', 35, 'Male', 'Cardiology'),
    ('DC002', 'Susmita Ghosh', 42, 'Female', 'Dermatology'),
    ('DC003', 'Ritwick Ghatak', 52, 'Male', 'Cardiology'),
    ('DC004', 'Madhuparna Ghosh', 29, 'Female', 'Nutritionist'),
    ('DC005', 'Ashish Jha', 40, 'Male', 'Neurology');

INSERT INTO patients
VALUES 
    ('PT001', 'Prannoy Chakroborty', 25, 'Male', 'DC001'),
    ('PT002', 'Ritabrata Das', 32, 'Male', 'DC003'),
    ('PT003', 'Shubhabrata Ghosh', 18, 'Male', 'DC003'),
    ('PT004', 'Archishman Das', 15, 'Male', 'DC002'),
    ('PT005', 'Madhulina Guha', 30, 'Female', 'DC001'),
    ('PT006', 'Avishikta Banerjee', 65, 'Female', 'DC003'),
    ('PT007', 'Mousumi Banerjee', 45, 'Female', 'DC002'),
    ('PT008', 'Meghla Sen', 52, 'Female', 'DC005'),
    ('PT009', 'Vijay Ghosh', 19, 'Male', 'DC005'),
    ('PT010', 'Manish Kumar Singh', 26, 'Male', 'DC001'),
    ('PT011', 'Sayantan Dhara', 37, 'Male', 'DC004'),
    ('PT012', 'Anurag Sarkar', 28, 'Male', 'DC002'),
    ('PT013', 'Ashmi Chattaraj', 32, 'Female', 'DC004'),
    ('PT014', 'Ayushi Meena', 41, 'Female', 'DC001'),
    ('PT015', 'Siddhi Agarkar', 15, 'Female', 'DC001'),
    ('PT016', 'Anubhav Mandal', 28, 'Male', 'DC004'),
    ('PT017', 'Anmol Sharma', 25, 'Male', 'DC005');

--1
SELECT SM.speciality AS 'Speciality', ROUND(MALEPATIENTS/FEMALEPATIENTS, 2) AS 'Gender Ratio'
FROM (SELECT COUNT(*) AS MALEPATIENTS, speciality 
      FROM patients  
      NATURAL JOIN doctors 
      WHERE patient_gender="Male" 
      GROUP BY speciality) SM  
JOIN (SELECT COUNT(*) AS FEMALEPATIENTS, speciality 
      FROM patients 
      NATURAL JOIN doctors 
      WHERE patient_gender="Female" 
      GROUP BY speciality) SF 
ON SF.speciality=SM.speciality;

--2
SELECT d.doctor_name, MAX(p.patient_age) - MIN(p.patient_age) AS 'Age Difference'
FROM doctors d
JOIN patients p
ON d.doctor_id = p.doctor_id
WHERE p.patient_gender = 'Male'
GROUP BY d.doctor_id;

--3
SELECT SM.doctor_id, FEMALEPATIENTS/MALEPATIENTS AS RATIO 
FROM ((SELECT COUNT(*) AS MALEPATIENTS, doctor_id 
        FROM patients 
        NATURAL JOIN doctors 
        WHERE patient_gender="Male" 
        GROUP BY doctor_id) SM  
JOIN (SELECT COUNT(*) AS FEMALEPATIENTS, doctor_id 
        FROM patients 
        NATURAL JOIN doctors 
        WHERE patient_gender="Female" 
        GROUP BY doctor_id)SF 
ON SF.doctor_id=SM.doctor_id)
WHERE FEMALEPATIENTS/MALEPATIENTS=
    (SELECT MAX(RATIO) FROM 
        (SELECT FEMALEPATIENTS/MALEPATIENTS AS RATIO FROM 
            (SELECT COUNT(*) AS MALEPATIENTS,doctor_id 
             FROM patients 
             NATURAL JOIN doctors 
             WHERE patient_gender="Male" 
            GROUP BY doctor_id) SM
        JOIN (SELECT COUNT(*) AS FEMALEPATIENTS,doctor_id 
        FROM patients 
        NATURAL JOIN doctors 
        WHERE patient_gender="Female" 
        GROUP BY doctor_id)SF 
        ON SF.doctor_id=SM.doctor_id)SD);

--4
SELECT COUNT(d.doctor_name) AS 'No of Doctors'
FROM doctors d
JOIN patients p
ON d.doctor_id = p.doctor_id
WHERE p.patient_age < 20;

--5
SELECT d.doctor_name, COUNT(p.patient_id) as num_patients
FROM doctors d
JOIN patients p 
ON d.doctor_id = p.doctor_id
WHERE d.doctor_name LIKE 'A%'
GROUP BY d.doctor_id
ORDER BY num_patients DESC
LIMIT 1;

