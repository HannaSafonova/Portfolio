/*1. Provide the average salary of employees for each year 
(average earnings among those who worked during the reporting period - 
statistics from the beginning up to 2005)*/

-- option 1
-- finding average salary to 2002 year
CREATE TABLE average_salary AS
SELECT YEAR(s.from_date) AS `year`, ROUND(AVG(s.salary),2) AS `average_salary`
  FROM salaries s
 GROUP BY YEAR(s.from_date)
 ORDER BY `year`;
 -- memorization value average salary for 2002 year
SELECT @avgs_2002:=average_salary.`average_salary`
  FROM
    average_salary
  WHERE `year`=2002;
 
 -- creating a request to 2005 year;
SELECT average_salary.* FROM average_salary
UNION ALL 
SELECT '2003', ROUND(@avgs_2002,2)
UNION ALL
SELECT '2004', ROUND(@avgs_2002,2)
UNION ALL
SELECT '2005', ROUND(@avgs_2002,2);

-- option 2
-- if all years (to 2005) would be represented in column `salaries.from_date`
SELECT DISTINCT YEAR(q.from_date) AS `YEAR`, 
                q.avg_salary AS 'the average salary of employees'
FROM 
-- finding the average salaries by year for employees
  (SELECT s.from_date,  
         ROUND(AVG(s.salary) OVER(partition BY YEAR(s.from_date)),2) AS avg_salary
     FROM salaries s)q
 -- selecting only period before year 2005     
WHERE YEAR(q.from_date)<=2005;

/*2. Display the average salary of employees for each department. 
Note: consider only current departments and current salaries.*/

-- option 1
SELECT de.dept_no AS Department, ROUND(AVG(s.salary),2) AS 'the average salary of employees'
  FROM salaries s 
	INNER JOIN dept_emp de ON s.emp_no=de.emp_no
                        AND de.to_date>curdate()
  WHERE s.to_date>curdate()
GROUP BY de.dept_no
ORDER BY de.dept_no
  ;
  
-- option 2
SELECT DISTINCT q.dept_no AS department, 
                q.avg_salary AS 'the average salary of employees'
FROM 
-- finding the average salaries by department for employees
  (SELECT de.dept_no,
	 ROUND(AVG(s.salary) OVER(partition BY de.dept_no),2) AS avg_salary
     FROM salaries s
         INNER JOIN dept_emp de ON s.emp_no=de.emp_no
                                AND de.to_date>curdate()
	WHERE s.to_date>curdate())q    
;

/*3. Provide the average salary of employees for each department per year.
 Note: To calculate the average salary of department X in year Y, 
 we need to take the mean of all salaries in year Y for employees
 who were in department X in year Y*/

/*SELECT s.*,de.*
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no=de.emp_no
WHERE s.emp_no=10010;*/

-- option 1
SELECT de.dept_no AS department, YEAR(s.from_date) AS `year`, ROUND(AVG(s.salary),2) AS 'the average salary of employees'
  FROM salaries s
  INNER JOIN dept_emp de ON s.emp_no=de.emp_no   
						 AND de.to_date>=s.from_date AND de.from_date<=s.from_date
 GROUP BY de.dept_no,YEAR(s.from_date)
ORDER BY de.dept_no, `year`;

-- option 2
SELECT DISTINCT q.dept_no AS department, YEAR(q.from_date) AS `YEAR`, 
                q.avg_salary AS 'the average salary of employees'
FROM 
  (SELECT de.dept_no, s.from_date,  
         ROUND(AVG(s.salary) OVER(partition BY de.dept_no, YEAR(s.from_date)),2) AS avg_salary
     FROM salaries s
       INNER JOIN dept_emp de ON s.emp_no=de.emp_no
							  AND de.to_date>=s.from_date AND de.from_date<=s.from_date
       )q  
;

/*4. Show the largest department (in terms of the number of employees) 
for each year and its average salary.*/

WITH `count_emp_no` AS 
-- finding for each year, each department the number of employees
(SELECT YEAR(from_date) AS `year`, 
        dept_no, COUNT(emp_no)AS count_empl
   FROM dept_emp
 GROUP BY YEAR(from_date), dept_no)
 
-- finding for each year, each department max number of employees
SELECT DISTINCT q.`year`, q.dept_no AS department, q.count_empl, q1.average_salary
  FROM
    (SELECT *, MAX(count_empl)OVER(PARTITION BY `year`) AS max
        FROM `count_emp_no`)q

INNER JOIN 

-- finding for each year, each department, average salary
(SELECT de.dept_no, YEAR(s.from_date) AS `year`, ROUND(AVG(s.salary),2) AS average_salary
  FROM salaries s
  INNER JOIN dept_emp de ON s.emp_no=de.emp_no   
						 AND de.to_date>=s.from_date AND de.from_date<=s.from_date
 GROUP BY YEAR(s.from_date), de.dept_no) q1 
                                      ON q.dept_no=q1.dept_no
                                      AND q.`year`=q1.`year`
WHERE count_empl=max;


/*5. Provide detailed information about the manager who has been 
in their position the longest currently.*/

SELECT q1.emp_no, q1.birth_date, q1.first_name, q1.last_name, q1.gender, q1.hire_date,
       q1.dept_no, q1.dept_name, q1.title, q1.from_date, q1.to_date, q1.salary
  FROM
   (SELECT e.*,d.dept_no, d.dept_name, q.from_date, q.to_date, s.salary, t.title, q.diff,
        MAX(q.diff) OVER() AS  max
     FROM  employees e 
   INNER JOIN salaries s ON e.emp_no=s.emp_no
                        AND s.to_date>curdate()
   INNER JOIN titles t ON s.emp_no=t.emp_no
                        AND t.to_date>curdate()
   INNER JOIN (SELECT *, DATEDIFF(curdate(),from_date) AS diff
                 FROM dept_manager 
               WHERE to_date>curdate())q
                               ON t.emp_no=q.emp_no                         
   INNER JOIN departments d ON q.dept_no=d.dept_no)q1
  WHERE diff=max
  ;
   
     
/*6. Display the top 10 current company employees with the largest difference 
between their salary and the current average salary in their respective departments.*/
 
SELECT q.emp_no, ABS(q.salary-q.avg_salary) AS diff
  FROM
    -- average salary by department
   (SELECT de.emp_no, de.dept_no, salary, 
           AVG(s.salary)OVER(partition BY de.dept_no)AS avg_salary       
      FROM salaries s
	  INNER JOIN dept_emp de ON s.emp_no=de.emp_no
                             AND de.to_date>curdate()
   WHERE s.to_date>curdate())q
ORDER BY diff DESC
LIMIT 10
;



/*7. Due to the crisis, only 500,000 dollars are allocated for timely salary 
payments to one department. The management has decided that the low-paid employees 
will be the first to receive their salaries. Display a list of all employees who will
 receive their salaries on time (note that we need to pay a monthly salary, 
 but we store annual amounts in the database).*/

SELECT q.emp_no 
  FROM
   (SELECT s.emp_no, s.salary/12, 
           SUM(s.salary/12) OVER(ORDER BY s.salary/12 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS `SUM`
      FROM salaries s
     WHERE to_date>curdate()
    ORDER BY s.salary)q
WHERE q.`SUM`<=500000;