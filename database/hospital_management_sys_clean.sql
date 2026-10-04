-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_management_sys
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `Appointment_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Doctor_ID` int DEFAULT NULL,
  `Appointment_Date` date DEFAULT NULL,
  `Appointment_Time` time DEFAULT NULL,
  `Status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Appointment_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Doctor_ID` (`Doctor_ID`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`Doctor_ID`) REFERENCES `doctor` (`Doctor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (225,111,201,'2026-10-01','03:15:00','Scheduled'),(401,101,201,'2026-09-15','09:30:00','Completed'),(402,102,202,'2026-09-16','10:00:00','Completed'),(403,103,203,'2026-09-17','11:00:00','Completed'),(404,104,204,'2026-09-18','12:00:00','Scheduled'),(405,105,205,'2026-09-19','14:30:00','Completed');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `Bill_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Appointment_ID` int DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Bill_Date` date DEFAULT NULL,
  `Payment_Status` varchar(30) DEFAULT NULL,
  `Consultation_Fee` decimal(10,2) DEFAULT '0.00',
  `Medicine_Charges` decimal(10,2) DEFAULT '0.00',
  `Laboratory_Charges` decimal(10,2) DEFAULT '0.00',
  `Room_Charges` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`Bill_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Appointment_ID` (`Appointment_ID`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`),
  CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`Appointment_ID`) REFERENCES `appointment` (`Appointment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` VALUES (901,106,401,2500.00,'2026-09-20','Paid',0.00,0.00,0.00,0.00),(902,107,402,1800.00,'2026-09-21','Paid',0.00,0.00,0.00,0.00),(903,108,403,3500.00,'2026-09-22','Pending',0.00,0.00,0.00,0.00),(904,109,404,1200.00,'2026-09-23','Paid',0.00,0.00,0.00,0.00),(905,110,405,2200.00,'2026-09-24','Pending',0.00,0.00,0.00,0.00);
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `Department_ID` int NOT NULL,
  `Department_Name` varchar(100) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Cardiology','Block A','8123456701'),(2,'Neurology','Block B','8234567812'),(3,'Orthopedics','Block C','8345678923'),(4,'Pediatrics','Block D','8456789034'),(5,'General Medicine','Block E','8567890145');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `Doctor_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Specialization` varchar(100) DEFAULT NULL,
  `Qualification` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Department_ID` int DEFAULT NULL,
  PRIMARY KEY (`Doctor_ID`),
  KEY `Department_ID` (`Department_ID`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `department` (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (201,'Dr. Arun Kumar','Cardiologist','MD Cardiology','9345678120',1),(202,'Dr. Priya Sharma','Neurologist','MD Neurology','9456781231',2),(203,'Dr. Ravi Teja','Orthopedic Surgeon','MS Orthopedics','9567812342',3),(204,'Dr. Anitha Rao','Pediatrician','MD Pediatrics','9678123453',4),(205,'Dr. Kiran Reddy','General Physician','MBBS, MD','9781234564',5);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory_test`
--

DROP TABLE IF EXISTS `laboratory_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory_test` (
  `Test_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Appointment_ID` int DEFAULT NULL,
  `Test_Name` varchar(100) DEFAULT NULL,
  `Test_Date` date DEFAULT NULL,
  `Result` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Test_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Appointment_ID` (`Appointment_ID`),
  CONSTRAINT `laboratory_test_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`),
  CONSTRAINT `laboratory_test_ibfk_2` FOREIGN KEY (`Appointment_ID`) REFERENCES `appointment` (`Appointment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory_test`
--

LOCK TABLES `laboratory_test` WRITE;
/*!40000 ALTER TABLE `laboratory_test` DISABLE KEYS */;
INSERT INTO `laboratory_test` VALUES (801,106,401,'Blood Test','2026-09-20','Normal'),(802,107,402,'Lipid Profile','2026-09-21','Within normal range'),(803,108,403,'X-Ray','2026-09-22','No abnormality detected'),(804,109,404,'Complete Blood Count','2026-09-23','Normal'),(805,110,405,'Blood Sugar Test','2026-09-24','Normal');
/*!40000 ALTER TABLE `laboratory_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_record`
--

DROP TABLE IF EXISTS `medical_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_record` (
  `Record_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Diagnosis` varchar(200) DEFAULT NULL,
  `Treatment` varchar(200) DEFAULT NULL,
  `Record_Date` date DEFAULT NULL,
  `Notes` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`Record_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  CONSTRAINT `medical_record_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_record`
--

LOCK TABLES `medical_record` WRITE;
/*!40000 ALTER TABLE `medical_record` DISABLE KEYS */;
INSERT INTO `medical_record` VALUES (601,101,'Hypertension','Blood pressure monitoring','2026-09-15','Regular monitoring required'),(602,103,'Knee Pain','Physiotherapy','2026-09-17','Avoid heavy physical activity'),(603,105,'Gastritis','Dietary and medical treatment','2026-09-19','Follow-up recommended'),(604,108,'Seasonal Allergy','Symptom management','2026-09-22','Avoid known allergens'),(605,110,'Migraine','Pain management and rest','2026-09-24','Follow-up if symptoms persist');
/*!40000 ALTER TABLE `medical_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `Medicine_ID` int NOT NULL,
  `Medicine_Name` varchar(100) NOT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Manufacturer` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  PRIMARY KEY (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES (301,'Paracetamol','Tablet','Cipla',2.50,500),(302,'Amoxicillin','Capsule','Sun Pharma',8.00,300),(303,'Azithromycin','Tablet','Alkem',12.50,250),(304,'Cetirizine','Tablet','Dr Reddys',3.50,400),(305,'Pantoprazole','Tablet','Lupin',5.00,350);
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `Patient_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `Blood_Group` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (101,'Ravi Kumar','2004-08-15','Male','9000001001','Vijayawada, NTR District','O+'),(102,'Sravani Devi','2002-03-22','Female','9000001002','Kakinada, Kakinada District','A+'),(103,'Harish Rao','1998-11-10','Male','9000001003','Guntur, Guntur District','B+'),(104,'Lakshmi Priya','2005-06-05','Female','9000001004','Kurnool, Kurnool District','AB+'),(105,'Vamsi Krishna','2001-01-28','Male','9000001005','Rajamahendravaram, East Godavari District','O-'),(106,'Anjali Reddy','2003-04-12','Female','9000001006','Visakhapatnam, Andhra Pradesh','A+'),(107,'Sai Teja','1999-09-25','Male','9000001007','Eluru, Andhra Pradesh','B+'),(108,'Pooja Sharma','2004-12-08','Female','9000001008','Hyderabad, Telangana','O+'),(109,'Naveen Kumar','1997-07-19','Male','9000001009','Warangal, Telangana','AB+'),(110,'Deepika Rao','2001-02-14','Female','9000001010','Tirupati, Andhra Pradesh','O-'),(111,'Priya','2007-04-19','Female','9087654532','Visakhapatnam','0+');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `Prescription_ID` int NOT NULL,
  `Patient_ID` int DEFAULT NULL,
  `Doctor_ID` int DEFAULT NULL,
  `Medicine_ID` int DEFAULT NULL,
  `Dosage` varchar(50) DEFAULT NULL,
  `Duration` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Prescription_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Doctor_ID` (`Doctor_ID`),
  KEY `Medicine_ID` (`Medicine_ID`),
  CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient` (`Patient_ID`),
  CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`Doctor_ID`) REFERENCES `doctor` (`Doctor_ID`),
  CONSTRAINT `prescription_ibfk_3` FOREIGN KEY (`Medicine_ID`) REFERENCES `medicine` (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (701,101,201,301,'As prescribed','7 days'),(702,103,203,302,'As prescribed','5 days'),(703,105,205,305,'As prescribed','10 days'),(704,108,204,304,'As prescribed','5 days'),(705,110,202,303,'As prescribed','3 days');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `Room_ID` int NOT NULL,
  `Room_Number` varchar(20) DEFAULT NULL,
  `Room_Type` varchar(50) DEFAULT NULL,
  `Floor` int DEFAULT NULL,
  `Availability` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (501,'A101','General',1,'Available'),(502,'A205','Private',2,'Occupied'),(503,'B301','ICU',3,'Occupied'),(504,'B402','Semi-Private',4,'Available'),(505,'C501','Emergency',5,'Available');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `Staff_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Role` varchar(30) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Staff_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (225,'Anitha','Nurse','9876543210'),(335,'Suresh','Receptionist','9876543211'),(444,'Priya','Nurse','9876543214'),(667,'Kavya','Nurse','9876543212'),(888,'Rahul','Receptionist','9876543213');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-04  9:45:16
