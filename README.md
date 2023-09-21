# Portfolio 

## SQL
### Project1. Database design writing in SQL

1. Design a database for course management. The database contains the following entities:
a. students: student_no, teacher_no, course_no, student_name, email, birth_date.
b. teachers: teacher_no, teacher_name, phone_no.
c. courses: course_no, course_name, start_date, end_date.

● Partition the students table by years using the range mechanism on the birth_date field.
● In the students table, establish a composite primary key consisting of student_no and birth_date.
● Create an index on the students.email field.
● Establish a unique index on the teachers.phone_no field.

2. Add test data at your discretion (7-10 rows) to our three tables.
   
3. Display data for any year from the "students" table and record in the form of 
a comment the execution plan of the query, indicating that the query will 
be executed on a specific partition.

4. Retrieve the teacher's data using any phone number, and document the execution plan to show 
that the query will be executed using an index rather than the ALL method. Then, make the index on 
the "teachers.phone_no" field invisible and document the execution plan where the expected result 
is the ALL method. Finally, leave the index in a visible status.

5. Intentionally create 3 duplicates in the 'students' table (add 3 more identical rows).

6. Write a query that outputs rows with duplicates.

## Project2. Requests writing in SQL



● Database design and requests writing in SQL  

● Exploratory analysis of the Ikea database with machine learning elements written 
in Python.  

● Visual analysis of the world happiness report in 2018 made with Tableau 

● Visual analysis of the world happiness report in 2015-2022 made with Power BI 
