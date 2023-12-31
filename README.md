![](/images/sql.jfif)

## [Project 1. Database design writing in SQL](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL%20Design.sql)
1. Designing a database for course management, using operators: **CREATE DATABASE, CREATE TABLE, CREATE INDEX,
   CREATE UNIQUE INDEX**, types: **PRIMARY KEY, PARTITION BY RANGE**.
   The database contains the following tables: students, teachers, and courses.
- Partitioning the students table by years using the range mechanism on the birth_date field.
- Establishing a composite primary key consisting of student_no and birth_date, in the students table
- Creating an index on the students.email field.
- Establishing a unique index on the teachers.phone_no field.
2. Adding test data, using the operator **INSERT INTO**.
3. Writing a query that outputs rows with duplicates, using the **Window function COUNT**.

## [Project 2. Requests writing in SQL](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL%20Requests.sql)
1. Providing the average salary of employees for each year, using operators **SELECT, WHERE, GROUP BY, ORDER BY,
   nested requests**, functions: **YEAR, ROUND, AVG, window function ROUND**
2. Displaying the average salary of employees for each department, using **INNER JOIN**
3. Providing the average salary of employees for each department per year.
4. Showing the largest department (in terms of the number of employees) 
   for each year and its average salary, using **CTE, window function MAX**.
5. Providing detailed information about the manager who has been 
   in their position the longest currently, using function **DATEDIFF**.
6. Displaying the top 10 current company employees with the largest difference 
   between their salary and the current average salary in their respective departments, using operator **LIMIT,
   window function AVG**.

## [Project 3. Using Procedural Language in SQL](https://github.com/HannaSafonova/Portfolio/blob/main/SQL/SQL_ETL.sql)
1. Creating a **procedure** for adding a new employee with the necessary list of input parameters.
   If a non-existing job title is provided, displaying an error with the appropriate message.
2. Creating a **procedure** to update an employee's salary with the necessary list of input parameters.
   If a non-existing employee is provided, displaying an error with the appropriate message.
3. Creating a **procedure** for dismissing an employee involves deleting their entry from other tables.
   If a non-existing employee number is provided, displaying an error with the appropriate message
4. Creating a **function** that displays the current salary for an employee.

![](/images/python.png)

## [Project 4. Exploratory analysis of the Ikea database with machine learning elements written in Python](https://github.com/HannaSafonova/Portfolio/tree/main/Python)                
- Downloading data using the **requests and pandas** libraries.
- Creating the sql_step_project.db database using the **sqlite3** library.
- Evaluating the quality of the data set using the **Data Quality Framework** methodology.
- Сonsidering the distributions of each variable databases separately and in combination using the **seaborn
    and matplotlib** libraries.
   
 ![](/images/histogram_boxplot.jpg)
 
- Applying **two-factor analysis of variance** to test the dependence of variables.
- Constructing and applying a **linear regression model** to fill in missing numerical values.
   
![](/images/regresion.jpg)

- Creating a prediction model based on **DecisionTreeRegressor**.
- Creating a prediction model based on **KNeighborsRegressor**.
- Сhecking the effectiveness of the obtained models using the **cross-validation** technique.
- Comparing two built DecisionTreeRegressor and KNeighborsRegressor price prediction models by two metrics: **cross_val_score and 
    mean_squared_error**.
    
![](/images/tableau.png)
## [Project 5. Visual analysis of the world happiness report in 2018 made with Tableau](https://github.com/HannaSafonova/Portfolio/tree/main/Tableau)     
1. Comparison of Country Scores: Comparing each country's Score with the average Score within its continent, focusing on intervals below 
   the global mean score, using **the combined graphs, LOD calculations, and the Analytics pane**.
2. Continent Analysis: Examining the ratio of countries per continent, with a focus on the average Score values across continents, using 
   **the Table calculation**.
3. Top N Ranking: Ranking the top N countries based on their scores (N being a **parameter**).
4. Quality of Life Calculation: Computing the total value of "Quality of Life" by summing up various qualities for each country,
   using **the Calculated field**.
5. Identifying Below-Average Countries: Identifying countries with values below the global averages in terms of cumulative quality 
   indicators and scores. Utilizing linear regression to establish a relationship between the score and the cumulative qualities, using 
   **the Analytics pane**.

![](/images/tableau_graph.png) 

A study has been conducted with the assumption that by modifying individual qualities, it's possible to improve a country's score. 
A linear relationship between the score and the cumulative qualities, along with quality parameters, is used for this purpose.
The results are presented as a graph comparing scores before and after changes to specific qualities.

![](/images/PowerBI.jpg)

## [Project 6. Visual analysis of the world happiness report in 2015-2022 made with Power BI](https://github.com/HannaSafonova/Portfolio/tree/main/Power%20BI)
Cleaning the data and adding the DimCountry reference table with **Power Query**. Creating a DimCalendar directory using 
the **DAX** tabular function, creating all the necessary relationships between tables and **Measures (DAX)**.
  
- Top N Ranking. The top N ranking of countries is based on the Happiness Rank (with N being a **parameter**). This section also covers the 
   number of countries per region as a percentage and the average Happiness Score values per region relative to the overall average 
   Happiness Score.
- Heatmap. Comparison of happiness indicators across years and regions, using **Table heatmap visual** from Power BI store.
- Waterfall. Analysis of the differences in happiness indicators compared to values from previous years, both in numerical and 
   percentage terms.
- Line Graph. Exploring the relationship between Happiness Score and the composite variable Measures, which is the sum of average 
   happiness indicators.

![](/images/line.png)

- Map. Percentage-based parameters have been established for all happiness indicators to improve these indicators. New Measures and 
   Happiness Score values have been computed using the **linear relationship** between Happiness Score and Measures. A comparison has 
   been made between the new and old Happiness Score values.
  

![](/images/powerbi_image.png)






