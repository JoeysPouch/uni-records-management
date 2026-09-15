# Import Packages
import streamlit as st


def start_connection():
    """Connects to the SQL database"""
    return st.connection('mysql', type='sql')


# Five Queries of increasing complexity

# Query 1: Names of students in disciplinary cases
def query_disciplined_students():
    conn = start_connection()
    query = """SELECT 
                    student.name AS "Student Name", 
                    student_disciplinary_record.description AS "Description of Offence"
                FROM student 
                INNER JOIN student_disciplinary_record ON student.student_id = student_disciplinary_record.student_id;
                """
    return conn.query(query)

# Query 2: All lecturers from a department of choice
def query_lecturers_from_any_department(department):
    conn = start_connection()
    query = """SELECT 
                    lecturer.name AS "Lecturer Name"
                FROM lecturer
                INNER JOIN department ON lecturer.department_id = department.department_id
                WHERE department.department_name = :Department;"""
    data_packet = {"Department": department}

    return conn.query(query, params=data_packet)

# Query 3: Highest Marks in Modules
def query_highest_marks(top_n):
    conn = start_connection()
    query = """SELECT 
                student.name AS "Student Name", 
                enrolment.grade AS "Grade",
                course.name AS "Course Name"
            FROM student 
            INNER JOIN enrolment ON student.student_id = enrolment.student_id
            INNER JOIN course_offering ON enrolment.course_offering_id = course_offering.offering_id
            INNER JOIN course ON course_offering.course_code = course.course_code
            ORDER BY enrolment.grade DESC
            LIMIT :Limit;"""
    data_packet = {"Limit": top_n}

    return conn.query(query, params=data_packet)

# Query 4: Average Age on UG vs PG programs
def query_avg_age_ug_vs_pg():
    conn = start_connection()
    query = """SELECT
                    CASE
                        WHEN program.degree_awarded IN ('BA', 'BSc') THEN 'Undergraduate'
                        WHEN program.degree_awarded IN ('MA', 'MSc') THEN 'Postgraduate'
                        ELSE 'Neither'
                    END AS "Level",
                ROUND(AVG(DATEDIFF(CURDATE(), student.date_of_birth)) / 365.25, 2) AS "Average Age"
                FROM student
                INNER JOIN program ON student.program_id = program.program_id
                GROUP BY Level;"""
    return conn.query(query)

# Query 5: Summary Statistics for STEM vs Non-STEM grades
def query_stem_vs_stem_summary_stats():
    conn = start_connection()
    query = """SELECT 
                    CASE 
                        WHEN department.faculty IN ('Mathematics and Statistics', 'Natural Sciences') THEN 'STEM'
                        WHEN department.faculty IN ('Arts and Social Sciences', 'Business and Management') THEN 'Non-STEM'
                        ELSE 'Neither'
                    END AS "Category",
                    ROUND(AVG(enrolment.grade), 2) AS Average,
                    ROUND(STDDEV(enrolment.grade), 2) AS "Standard Deviation",
                    ROUND(MAX(enrolment.grade), 2) AS "Highest Mark",
                    ROUND(MIN(enrolment.grade), 2) AS "Lowest Mark"
                FROM enrolment
                INNER JOIN course_offering ON enrolment.course_offering_id = course_offering.offering_id
                INNER JOIN course ON course_offering.course_code = course.course_code
                INNER JOIN department ON course.department_id = department.department_id
                GROUP BY Category;
                """
    return conn.query(query)


def query_test():
    conn = start_connection()
    return conn.query('SELECT * FROM department')
