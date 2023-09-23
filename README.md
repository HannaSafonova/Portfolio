![](/images/sql.jfif)

## [Project 1. Database design writing in SQL.](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL%20Design.sql)
1. Designing a database for course management.
   The database contains the following entities:
 a. students: student_no, teacher_no, course_no, student_name, email, birth_date.
 b. teachers: teacher_no, teacher_name, phone_no.
 c. courses: course_no, course_name, start_date, end_date.
- Partitioning the students table by years using the range mechanism on the birth_date field.
- In the students table, establishing a composite primary key consisting of student_no and birth_date.
- Creating an index on the students.email field.
- Establishing a unique index on the teachers.phone_no field.
2. Adding test data.
3. Writing a query that outputs rows with duplicates.

## [Project 2. Requests writing in SQL.](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL%20Requests.sql)
1. Providing the average salary of employees for each year.
2. Displaying the average salary of employees for each department.
3. Providing the average salary of employees for each department per year.
4. Showing the largest department (in terms of the number of employees) 
   for each year and its average salary.
5. Providing detailed information about the manager who has been 
   in their position the longest currently.
6. Displaying the top 10 current company employees with the largest difference 
   between their salary and the current average salary in their respective departments.

## [Project 3. Using Procedural Language in SQL.](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL_ETL.sql)
1. Creating a **procedure** for adding a new employee with the necessary list of input parameters.
   If a non-existing job title is provided, displaying an error with the appropriate message.
2. Creating a **procedure**to update an employee's salary with the necessary list of input parameters.
   If a non-existing employee is provided, displaying an error with the appropriate message.
3. Creating a **procedure** for dismissing an employee, which involves deleting their entry 
   from other tables. If a non-existing employee number is provided, 
   displaying an error with the appropriate message.
4. Creating a **function** that displays the current salary for an employee.

![](/images/histogram_boxplot.jpg)

## [Project 4. Exploratory analysis of the Ikea database with machine learning elements written in Python.](https://github.com/HannaSafonova/Portfolio/tree/main/Python)                
1. Downloading data using the **requests and pandas** libraries.
2. Creating of the sql_step_project.db database using the **sqlite3** library.
3. Evaluating the quality of the data set using the **Data Quality Framework** methodology.
4. Сonsidering the distributions of each variable databases separately and in combination using the **seaborn
    and matplotlib** libraries.
   ![](/images/(/images/histogram_boxplot.jpg)
6. Applying **two-factor analysis of variance** to test the dependence of variables.
7. Constructiing a **linear regression** model and applying it to fill in missing numerical values.
8. Creating a prediction model based on **DecisionTreeRegressor**.
9. Creating a prediction model based on **KNeighborsRegressor**.
10. Сhecking the effectiveness of the obtained models using the **cross-validation** technique.
11. Comparing two built DecisionTreeRegressor and KNeighborsRegressor price prediction models by two metrics: **cross_val_score and 
    mean_squared_error**.




● Visual analysis of the world happiness report in 2018 made with Tableau 

● Visual analysis of the world happiness report in 2015-2022 made with Power BI 
