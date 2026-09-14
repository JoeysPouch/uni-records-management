# Import Packages
import pandas as pd
import streamlit as st



def start_connection():
    """Connects to the SQL database"""
    return st.connection('mysql', type = 'sql')



# Five Queries of increasing complexity

# Query 1: Names of students in disciplinary cases
def query_disciplined_students():
    conn = start_connection()
    query = """SELECT 
                    student.name, 
                    student_disciplinary_record.description
                FROM student 
                INNER JOIN student_disciplinary_record ON student.student_id = student_disciplinary_record.student_id;
                """
    return conn.query(query)

# Query 2: All lecturers from a department of choice
def query_lecturers_from_any_department(department):
    conn = start_connection()
    query = """SELECT 
                    lecturer.name
                FROM lecturer
                INNER JOIN department ON lecturer.department_id = department.department_id
                WHERE department.department_name = :Department;"""
    data_packet = {"Department": department}

    return conn.query(query, params = data_packet)

# Query 3: Highest Marks in Modules
def query_highest_marks(top_n):
    conn = start_connection()
    query = """SELECT 
                student.name, 
                enrolment.grade 
            FROM student 
            INNER JOIN enrolment ON student.student_id = enrolment.student_id
            ORDER BY enrolment.grade DESC
            LIMIT :Limit;"""
    data_packet = {"Limit": top_n}

    return conn.query(query, params = data_packet)

# Query 4: Average Age on UG vs PG programs
def query_avg_age_ug_vs_pg():
    conn = start_connection()
    query = """SELECT
                program.degree_awarded,
                ROUND(AVG(DATEDIFF(CURDATE(), student.date_of_birth)) / 365.25, 2) AS average_age
                FROM student
                INNER JOIN program ON student.program_id = program.program_id
                GROUP BY program.degree_awarded"""
    return conn.query(query)

# Query 5: Summary Statistics for STEM vs Non-STEM grades
def query_stem_vs_stem_summary_stats():
    conn = start_connection()
    query = """SELECT 
                    CASE 
                        WHEN department.faculty IN ('Mathematics and Statistics', 'Natural Sciences') THEN 'STEM'
                        WHEN department.faculty IN ('Arts and Social Sciences', 'Business and Management') THEN 'Non-STEM'
                        ELSE 'Neither'
                    END AS group_type,
                    ROUND(AVG(enrolment.grade), 2) AS average,
                    ROUND(STDDEV(enrolment.grade), 2) AS st_dev,
                    ROUND(MAX(enrolment.grade), 2) AS highest_mark,
                    ROUND(MIN(enrolment.grade), 2) AS lowest_mark
                FROM enrolment
                INNER JOIN course_offering ON enrolment.course_offering_id = course_offering.offering_id
                INNER JOIN course ON course_offering.course_code = course.course_code
                INNER JOIN department ON course.department_id = department.department_id
                GROUP BY group_type;
                """
    return conn.query(query)
    



def query_test():
    conn = start_connection()
    return conn.query('SELECT * FROM department')

print(query_test())
print(query_highest_marks(5))
print(query_disciplined_students())
print(query_lecturers_from_any_department("Business"))
print(query_avg_age_ug_vs_pg())
print(query_stem_vs_stem_summary_stats())
