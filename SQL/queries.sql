
USE hospital_management_sys;

-- =========================================
-- 1. PATIENT
-- =========================================

-- Display all patients
SELECT * FROM patient;

-- Search patient by name
SELECT *
FROM patient
WHERE Name LIKE '%John%';


-- =========================================
-- 2. DOCTOR
-- =========================================

-- Display all doctors
SELECT * FROM doctor;

-- Display doctors with their departments
SELECT
    d.Doctor_ID,
    d.Name AS Doctor_Name,
    d.Specialization,
    dp.Department_Name
FROM doctor d
JOIN department dp
    ON d.Department_ID = dp.Department_ID;


-- =========================================
-- 3. STAFF
-- =========================================

-- Display all staff
SELECT * FROM staff;

-- Display staff by role
SELECT *
FROM staff
WHERE Role = 'Nurse';


-- =========================================
-- 4. DEPARTMENT
-- =========================================

-- Display all departments
SELECT * FROM department;

-- Count doctors in each department
SELECT
    dp.Department_Name,
    COUNT(d.Doctor_ID) AS Total_Doctors
FROM department dp
LEFT JOIN doctor d
    ON dp.Department_ID = d.Department_ID
GROUP BY dp.Department_ID, dp.Department_Name;


-- =========================================
-- 5. APPOINTMENT
-- =========================================

-- Display all appointments
SELECT * FROM appointment;

-- Display appointment details with patient and doctor names
SELECT
    a.Appointment_ID,
    p.Name AS Patient_Name,
    d.Name AS Doctor_Name,
    a.Appointment_Date,
    a.Appointment_Time,
    a.Status
FROM appointment a
JOIN patient p
    ON a.Patient_ID = p.Patient_ID
JOIN doctor d
    ON a.Doctor_ID = d.Doctor_ID;


-- =========================================
-- 6. MEDICAL RECORD
-- =========================================

-- Display all medical records
SELECT * FROM medical_record;

-- Display medical records with patient names
SELECT
    m.Record_ID,
    p.Name AS Patient_Name,
    m.Diagnosis,
    m.Treatment,
    m.Record_Date,
    m.Notes
FROM medical_record m
JOIN patient p
    ON m.Patient_ID = p.Patient_ID;


-- =========================================
-- 7. PRESCRIPTION
-- =========================================

-- Display all prescriptions
SELECT * FROM prescription;

-- Display prescription details with patient, doctor and medicine
SELECT
    pr.Prescription_ID,
    p.Name AS Patient_Name,
    d.Name AS Doctor_Name,
    me.Medicine_Name,
    pr.Dosage,
    pr.Duration
FROM prescription pr
JOIN patient p
    ON pr.Patient_ID = p.Patient_ID
JOIN doctor d
    ON pr.Doctor_ID = d.Doctor_ID
JOIN medicine me
    ON pr.Medicine_ID = me.Medicine_ID;


-- =========================================
-- 8. MEDICINE
-- =========================================

-- Display all medicines
SELECT * FROM medicine;

-- Display medicines with available stock
SELECT
    Medicine_ID,
    Medicine_Name,
    Category,
    Price,
    Stock
FROM medicine
WHERE Stock > 0;


-- =========================================
-- 9. LABORATORY TEST
-- =========================================

-- Display all laboratory tests
SELECT * FROM laboratory_test;

-- Display laboratory tests with patient names
SELECT
    l.Test_ID,
    p.Name AS Patient_Name,
    l.Test_Name,
    l.Test_Date,
    l.Result
FROM laboratory_test l
JOIN patient p
    ON l.Patient_ID = p.Patient_ID;


-- =========================================
-- 10. ROOM
-- =========================================

-- Display all rooms
SELECT * FROM room;

-- Display available rooms
SELECT *
FROM room
WHERE Availability = 'Available';


-- =========================================
-- 11. BILLING
-- =========================================

-- Display all billing records
SELECT * FROM billing;

-- Display billing details with patient names
SELECT
    b.Bill_ID,
    p.Name AS Patient_Name,
    b.Amount,
    b.Bill_Date,
    b.Payment_Status,
    b.Consultation_Fee,
    b.Medicine_Charges,
    b.Laboratory_Charges,
    b.Room_Charges
FROM billing b
JOIN patient p
    ON b.Patient_ID = p.Patient_ID;


-- =========================================
-- SUMMARY QUERIES
-- =========================================

-- Total number of patients
SELECT COUNT(*) AS Total_Patients
FROM patient;

-- Total number of doctors
SELECT COUNT(*) AS Total_Doctors
FROM doctor;

-- Total number of appointments
SELECT COUNT(*) AS Total_Appointments
FROM appointment;

-- Total number of medicines
SELECT COUNT(*) AS Total_Medicines
FROM medicine;

-- Total number of rooms
SELECT COUNT(*) AS Total_Rooms
FROM room;

