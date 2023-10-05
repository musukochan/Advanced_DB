import random
from faker import Faker
import datetime
import mariadb

# Create a connection to the database
db = mariadb.connect(
    host="127.0.0.1",
    port=3306,
    user="root",
    password="mariadb",
    database="mariadb"
)

# Create a database cursor on this connection
# This creates a work area for us in the same way as opening a console via a DB client
# It will allow us to execute SQL statements on the database associated with the connection
cursor = db.cursor()

fake = Faker()
print ("Generating random student data")
# Generate random student data and insert into the Students table
for i in range(1, 101):  # Generate data for 100 students
    first_name = fake.first_name()
    last_name = fake.unique.last_name()
    dob = fake.date_of_birth(minimum_age=18, maximum_age=25)
    semail = first_name + "." + last_name + "@exuni.ie"
# Execute the insert statement on the database
    cursor.execute("INSERT INTO Students ( StudentID, FirstName, LastName, DateOfBirth, Email ) VALUES (%s, %s, %s, %s, %s)",
                   (i,first_name, last_name, dob, semail))

print ("Generating random department data")
# Generate random department data and insert into the Departments table
for i in range(1, 11):  # Generate data for 10 depts
    dept_name = fake.word()
    cursor.execute("INSERT INTO Departments (DEPTID, DEPTNAME) VALUES (%s,%s)", (i,dept_name))

print ("Generating random course data")
# Generate random coursedata and insert into the Courses table
for i in range(1, 11):  # Generate data for 10 courses for each department
    course_name = fake.word()
    professor = "Dr. " + fake.first_name() + "," + fake.last_name()
    cursor.execute("INSERT INTO Courses (CourseID, CourseName, Professor) VALUES (%s, %s, %s)", (i, course_name, professor))

print ("Generating random exam data")
# Generate random exam data and insert into the Exams table
exam_id=0
for i in range(1, 11):
# Generate data for 10 exams for each course in each department
    for j in range(1, 11):
        exam_id=exam_id+1
        cursor.execute("INSERT INTO Exams (ExamID, DeptID, CourseID) VALUES (%s, %s, %s)", (exam_id, i,j))

print ("Generating result data")
resid=0
# Generate random exam results and insert into the ExamResults table
for i in range(1, 201):
    print("*")
    student_id=random.randrange(1, 101)
    resid=resid+1
    exam_id=random.randrange(1, 101)
    score = round(random.uniform(50, 100), 2)
    grade = random.choice(["A", "B", "C", "D", "F"])
    exam_date = fake.date_between_dates(datetime.date(2019, 1, 1), datetime.date(2022, 12, 31))
    cursor.execute("INSERT INTO ExamResults (ResID, StudentID, ExamID, Score, Grade, ExamDate) VALUES ( %s, %s, %s, %s, %s, %s)",
                       (resid, student_id, exam_id, score, grade, exam_date))


# Commit the changes and close the connection
db.commit()
# Retrieve the results
cursor.execute ("SELECT * from ExamResults")
studentresults=cursor.fetchall()
print("Total number of results inserted: ", cursor.rowcount)

print("\nPrinting each result")
for row in studentresults:
    print("StudentID = ", row[1])
    print("ExamID = ", row[2])
    print("Score  = ", row[3])
    print("Grade  = ", row[4])
    print("Exam Data =", row[5], "\n")

db.close()
