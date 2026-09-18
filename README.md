# University Records Management System
## Overview
This project is a database-driven record management system designed for a university. It handles the tracking and querying of various institutional entities, including students, lecturers, non-academic staff, courses, departments, academic programs, and research projects.

The application architecture consists of a normalized MySQL database backend and a Python-based graphical user interface built with Streamlit. The system enforces relational integrity across complex entities (such as many-to-many enrolment linkages and one-to-one advisory roles) and provides a frontend for users to execute analytical queries without writing raw SQL.

## Features
The interface exposes five core analytical queries implemented in the application layer:

**Disciplinary Record Auditing:** Retrieves student names alongside descriptions of any recorded offences from the disciplinary logs.
**Departmental Staff Directory:** Generates a filtered list of lecturers belonging to a user-selected department.
**Academic Leaderboards:** Queries and ranks the top N highest student grades across all course modules.
**Demographic Age Analysis:** Calculates the average age of students categorized by program level (Undergraduate vs. Postgraduate).
**STEM vs. Non-STEM Grade Analytics:** Generates aggregate statistical summaries (average grade, standard deviation, highest mark, and lowest mark) comparing STEM and Non-STEM faculties.

## Installation and Setup
1. Navigate to the project directory
Extract the submission folder (if zipped) and open your terminal or command prompt in the root project directory:

cd path/to/UNI-RECORDS-MANAGEMENT

2. Install dependencies
Create and activate a Python virtual environment (recommended), then install the required packages listed in the requirements file:

pip install -r requirements.txt

3. Database configuration
The application requires an active connection to the MySQL database.

Ensure your MySQL server is running.

Execute your database initialization scripts (schema creation and dummy data insertion) within your MySQL instance.

Verify that the database connection credentials (username, password, host, and database name) in the application code match your local MySQL configuration so the application can authenticate and query the database successfully.

4. Running the application
Once the database is active and dependencies are installed, launch the user interface by running the following command from the root directory of the project:

streamlit run src/ui_layer.py

The application will automatically open in your default web browser (typically at http://localhost:8501).
