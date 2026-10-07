# Hospital Management System

## 1. Project Overview

The Hospital Management System (HMS) is a database-driven web application developed to manage hospital operations and patient information efficiently.

The system replaces manual record maintenance with a centralized MySQL database. It helps reduce duplicate records, data-entry errors, and delays in retrieving patient information.

## 2. Objectives

- Manage patient information efficiently
- Manage doctors and staff
- Manage departments
- Schedule and manage appointments
- Maintain medical records
- Manage prescriptions and medicines
- Manage laboratory tests
- Manage rooms
- Manage billing information
- Provide online appointment booking

## 3. Modules

1. Dashboard
2. Patients
3. Doctors
4. Staff
5. Departments
6. Appointments
7. Medical Records
8. Prescriptions
9. Medicines
10. Laboratory Tests
11. Rooms
12. Billing

## 4. Key Features

- Admin Login
- Patient CRUD operations
- Doctor management
- Staff management
- Department management
- Appointment management
- Medical record management
- Prescription management
- Medicine management
- Laboratory test management
- Room management
- Billing management
- Patient history
- Online appointment booking
- MySQL database integration

## 5. Technologies Used

### Frontend
- HTML
- CSS
- Jinja Templates

### Backend
- Python
- Flask

### Database
- MySQL

### Tools
- Visual Studio Code
- MySQL
- Git
- GitHub

### Deployment
- Railway

## 6. Database

The system uses a relational MySQL database.

The main tables are:

- Patient
- Doctor
- Department
- Appointment
- Medical Record
- Prescription
- Medicine
- Laboratory Test
- Room
- Billing
- Staff

Primary keys and foreign keys are used to establish relationships between tables and maintain data integrity.

## 7. Patient Appointment Booking

Patients can book appointments through the public website without accessing the admin dashboard.

The patient provides:

- Patient Name
- Phone Number
- Doctor
- Appointment Date
- Appointment Time

After submission, the appointment is stored in the MySQL database and can be viewed by the administrator.

## 8. System Architecture

```text
Patient
   |
   | Online Appointment Booking
   v
Flask Web Application
   |
   v
MySQL Database

## 9. Project Structure
Hospital-Management-System/
│
├── app.py
├── database.py
├── requirements.txt
├── Procfile
├── README.md
│
├── database/
├── SQL/
├── docs/
├── static/
└── templates/

##10. Database Integration

The Flask application connects to the MySQL database using mysql.connector.

The backend performs:

Insert
Select
Update
Delete
Search

## 11. Deployment

The application is deployed using Railway.

GitHub Repository
        |
        v
Railway
        |
        v
Flask Web Application
        |
        v
MySQL Database
Public Application

https://hms-production-1136.up.railway.app/

##12. Documentation

The repository contains:

ER Diagram
Relational Schema
SQL Queries
Database SQL File
Project Screenshots
Project Presentation

##13. Conclusion

The Hospital Management System provides a centralized platform for managing hospital operations and patient information.

It reduces manual work, improves data organization, provides faster access to patient information, and supports online appointment booking.

The project demonstrates the integration of a Flask web application with a relational MySQL database and cloud deployment.
