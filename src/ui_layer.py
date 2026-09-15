import streamlit as st
import application_layer as app

# Options and Associated Functions in the Application Layer
function_dict = {"Student Disciplinary Cases": app.query_disciplined_students,
                 "Highest Marks": app.query_highest_marks,
                 "Lecturers in a Given Department": app.query_lecturers_from_any_department,
                 "Ages of Undergraduate vs Postgraduate Students": app.query_avg_age_ug_vs_pg,
                 "STEM vs Non-STEM Summary Statistics": app.query_stem_vs_stem_summary_stats
                 }

pars = {}

# UI Logic
st.title("University Information Hub")

st.text("Welcome to the University Information Hub! Please select a topic and then click 'Collect Information' to access the database. A table with your results should appear below.")

query_options = st.radio(
    "Select a Topic ", list(function_dict.keys()), index=0)
print(query_options)

students = ""
if query_options == "Highest Marks":
    students = st.slider("Choose how many students to show",
                         max_value=10, min_value=1)
    pars["top_n"] = students

department = ""
if query_options == "Lecturers in a Given Department":
    department = st.radio("Please pick a department", ["Economics", "Politics", "Sociology", "Business",
                                                       "Supply Chain and Logistics", "Mathematics", "Statistics"], index=None)
    pars["department"] = department

# Button greyed out vs available logic
is_greyed_out = True
if query_options == "Student Disciplinary Cases":
    is_greyed_out = False
elif query_options == "Highest Marks" and students:
    is_greyed_out = False
elif query_options == "Lecturers in a Given Department" and department:
    is_greyed_out = False
elif query_options == "Ages of Undergraduate vs Postgraduate Students":
    is_greyed_out = False
elif query_options == "STEM vs Non-STEM Summary Statistics":
    is_greyed_out = False


# Chooses which function to call on press of button
f = function_dict[query_options]


def get_dataframe(**kwargs):
    return st.dataframe(f(**kwargs))


button = st.button("Collect Information",
                   help="Select an option and then press me!", disabled=is_greyed_out)

if button:
    results = f(**pars)
    st.dataframe(results)
    pars = {}
