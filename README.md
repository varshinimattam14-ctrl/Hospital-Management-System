# Hospital Management System

## 1. Project Overview

The Hospital Management System (HMS) is a database-driven web application developed to manage hospital operations and patient information efficiently.

The system replaces manual record maintenance with a centralized MySQL database. It helps reduce duplicate records, data-entry errors, and delays in retrieving patient information.

The application provides hospital administration features and online patient appointment booking.

## 2. Objectives

- Manage patient information efficiently
- Manage doctors and hospital staff
- Manage departments
- Schedule and manage appointments
- Maintain medical records
- Manage prescriptions and medicines
- Manage laboratory tests
- Manage hospital rooms
- Manage billing information
- Provide patient history
- Reduce manual work and data duplication
- Provide online appointment booking

## 3. Modules

The Hospital Management System contains the following modules:

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
- Dashboard
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
- Search functionality
- Online patient appointment booking
- MySQL database integration
- Public web deployment

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

### Development Tools
- Visual Studio Code
- MySQL
- Git
- GitHub

### Deployment
- Railway

## 6. Database

The system uses a relational MySQL database to store and manage hospital information.

The main database tables are:

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

Patients can book appointments through the public website without logging into the admin dashboard.

The patient provides:

- Patient Name
- Phone Number
- Doctor
- Appointment Date
- Appointment Time

After booking, the appointment is stored in the MySQL database and can be viewed by the administrator.

## 8. System Architecture

```text
Patient
   |
   | Online Appointment Booking
   v
Flask Web Application
   |
   | Backend Processing
   v
MySQL Database
   |
   +-- Patient
   +-- Doctor
   +-- Department
   +-- Appointment
   +-- Medical Record
   +-- Prescription
   +-- Medicine
   +-- Laboratory Test
   +-- Room
   +-- Billing
   +-- Staff

9. Project Structure

Hospital-Management-System/
│
├── app.py
├── database.py
├── requirements.txt
├── Procfile
├── README.md
│
├── database/
│   └── hospital_management_sys_clean.sql
│
├── SQL/
│   └── queries.sql
│
├── docs/
│   ├── ER_Diagram.png
│   ├── Relational_Schema.png
│   └── screenshots/
│
├── static/
│   └── ...
│
└── templates/
    ├── base.html
    ├── login.html
    ├── dashboard.html
    └── ...
10. Database Integration

The Flask application connects to the MySQL database using mysql.connector.

The backend performs the following database operations:

Insert
Select
Update
Delete
Search

The application uses environment variables for database configuration to keep database credentials separate from the source code.

11. Deployment

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

12. Documentation

The project repository contains the following documentation:

ER Diagram
Relational Schema
SQL Queries
Database SQL File
Project Screenshots
Project Presentation

13. Conclusion

The Hospital Management System provides a centralized platform for managing hospital operations and patient information.

It reduces manual work, improves data organization, provides faster access to patient information, and supports online appointment booking.

The project demonstrates the integration of a Flask web application with a relational MySQL database and cloud deployment.
