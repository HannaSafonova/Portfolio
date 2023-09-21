#                                        Portfolio 

##                                          SQL
                                         
 [###Project1. Database design writing in SQL] (https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL%20Design.sql)

1. Designing a database for course management.
   The database contains the following entities:
 a. students: student_no, teacher_no, course_no, student_name, email, birth_date.
 b. teachers: teacher_no, teacher_name, phone_no.
 c. courses: course_no, course_name, start_date, end_date.
- Partitioning the students table by years using the range mechanism on the birth_date field.
- In the students table, establishing a composite primary key consisting of student_no and birth_date.
- Creating an index on the students.email field.
- Establishing a unique index on the teachers.phone_no field.
2. Adding test data (7-10 rows) to our three tables.
3. Displaying data for any year from the "students" table and record in the form of 
   a comment the execution plan of the query, indicating that the query will 
   be executed on a specific partition.
4. Intentionally creating 3 duplicates in the 'students' table (add 3 more identical rows).
5. Writing a query that outputs rows with duplicates.

## Project2. Requests writing in SQL



● Database design and requests writing in SQL  

● Exploratory analysis of the Ikea database with machine learning elements written 
in Python.  

● Visual analysis of the world happiness report in 2018 made with Tableau 

● Visual analysis of the world happiness report in 2015-2022 made with Power BI 
