# Import Packages
import pandas as pd
import streamlit as st



def start_connection():
    """Connects to the SQL database"""
    return st.connection('mysql', type = 'sql')

# Query 1: High Achievers
def query_high_achievers(top_n):
    conn = start_connection()
    query = """SELECT 
                student.student_id, 
                student.name, 
                enrolment.grade 
            FROM student 
            INNER JOIN enrolment ON student.student_id = enrolment.student_id
            ORDER BY enrolment.grade DESC
            LIMIT :Limit;"""
    data_packet = {"Limit": top_n}
    conn.query(query, params = data_packet)
    # Change None to the query after testing
    return None

# Query 2: Students with disciplinary issues
def query_disciplined_students():
    conn = start_connection()
    pass

# Query 3: Prolific Lecturers
def query_prolific_lecturers(top_n):
    conn = start_connection()
    pass

# Query 4: Lecturers with difficult research areas
def query_lecturers_difficult_research_areas():
    conn = start_connection()
    pass

# Query 5: Average Salary by Employment Type
def query_avg_salary_by_employment_type():
    conn = start_connection()
    pass

def query_test():
    conn = start_connection()
    return conn.query('SELECT * from student')




