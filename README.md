
# Hosptial-Management-System
The Hospital Management System is a web-based application developed using Java, Servlets, JDBC, HTML, CSS, and MySQL. This system is designed to streamline and simplify the management of patient and doctor data in a hospital setting.

🔧 Technologies Used:
Frontend: HTML, CSS (for responsive and modern UI)

Backend: Java, Servlets

Database Connectivity: JDBC

Database: MySQL

✅ Key Features:
Add New Patient: Admin or staff can register new patients by entering their details.

View Patients: Display a list of all registered patients with search and filter options.

Edit Patient Info: Update or correct patient information as needed.

Book Appointment: Patients can be scheduled with available doctors based on specialization or availability.

View Doctor List: Displays all doctors along with their specialization and contact info.

Edit Doctor Info: Admin can update doctor details if necessary.

🎯 Purpose:
The main goal is to automate routine hospital operations such as maintaining patient records, managing doctor schedules, and booking appointments to increase efficiency and reduce paperwork.

🖥️ Modules Overview:
Patient Module: Add, update, and view patient details.

Doctor Module: View and manage doctor profiles.

Appointment Module: Book and track appointments between patients and doctors.

Tools Needed:

Eclipse IDE

MySQL Server

Apache Tomcat (Install and configure in Eclipse)

MySQL JDBC Connector (JAR file)

Steps to Run:

Open Eclipse and create a Dynamic Web Project

Copy all your HTML, CSS, Servlet, and Java files into the project

Add the MySQL JDBC JAR file to the project’s lib folder

Create a database in MySQL (e.g., hospital_db) and required tables
are patient,doctor,appointment.

Update your JDBC connection details in the servlet code

Right-click the project → Run on Server → Choose Tomcat

Access the Project:

Open browser and go to: http://localhost:8080/YourProjectName/
