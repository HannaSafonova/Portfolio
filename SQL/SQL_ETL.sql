/*
1. Create a procedure for adding a new employee with the necessary list of input parameters.
 After the procedure runs successfully, the data should be inserted into the 'employees', 
 'dept_emp', 'salaries', and 'titles' tables. Calculate the 'emp_no' using the formula 
 max(emp_no)+1. If a non-existing job title is provided, display an error with the appropriate message.
 If a salary less than 30000 is provided, display an error with the required text.
*/
DROP PROCEDURE IF EXISTS CREATE_NEW_EMPLOYEE;
DELIMITER //
CREATE PROCEDURE CREATE_NEW_EMPLOYEE(IN P_BIRTH_DATE DATE, P_FIRST_NAME VARCHAR(14), 
                                        P_LAST_NAME VARCHAR(16), P_GENDER ENUM('M','F'),
                                        P_DEPT_NO CHAR(4), P_TITLE VARCHAR(50), P_SALARY INT
                                        )
BEGIN 
  -- Let`s find the next namber of emp_no
    DECLARE NEW_EMP_NO INT;
    SET NEW_EMP_NO = (SELECT MAX(e.emp_no)+1 FROM employees e);
   
    -- Let`s check title if it exists    
     IF P_TITLE NOT IN (SELECT t.title FROM titles t)
	       THEN
		       SIGNAL SQLSTATE '45000' -- returns general purpose error
               SET MESSAGE_TEXT = 'The title does not exist';
	  END IF;
     -- Let`s check salary if it is more than 29999
      IF P_SALARY<30000
	       THEN
		       SIGNAL SQLSTATE '45000' -- returns general purpose error
               SET MESSAGE_TEXT = "The salary must be not less than 30000";
	  END IF; 

    START TRANSACTION;
       -- Let`s insert new records into tables 
       INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
		 VALUES(NEW_EMP_NO, P_BIRTH_DATE, P_FIRST_NAME, P_LAST_NAME, P_GENDER, CURDATE()); 

       INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
          VALUES(NEW_EMP_NO, P_DEPT_NO, CURDATE(), '9999-01-01');
          
       INSERT INTO salaries (emp_no, salary, from_date, to_date)
          VALUES(NEW_EMP_NO, P_SALARY, CURDATE(), '9999-01-01');
 
       INSERT INTO titles (emp_no, title, from_date, to_date)
          VALUES(NEW_EMP_NO, P_TITLE, CURDATE(), '9999-01-01');
      COMMIT;
END
//
DELIMITER ;
 
 -- Let`s test CREATE_NEW_EMPLOYEE procedure with valid values
CALL CREATE_NEW_EMPLOYEE('1985-07-07', 'Safonov','Mikle', 'M','d002','Staff',50001);
-- Let`s test CREATE_NEW_EMPLOYEE procedure with invalid values for the salary column
CALL CREATE_NEW_EMPLOYEE('1986-11-11', 'Volkov','Vlad', 'M','d002','Staff',2000);
-- Let`s test CREATE_NEW_EMPLOYEE procedure with invalid values for the title column
CALL CREATE_NEW_EMPLOYEE('1983-07-08', 'Chumachenko','Dmutro', 'M','d006','Enginer',200000);
                                        

/*
2. Create a procedure to update an employee's salary. When updating the salary, 
the last active record should be closed with the current date, and a new historical 
record should be created with the current date. If a non-existing employee is provided, 
display an error with the appropriate message.
*/

DROP PROCEDURE IF EXISTS EMP_TRANSFER;
DELIMITER $$
CREATE PROCEDURE EMP_TRANSFER(IN P_EMP_NO INT, P_SALARY INT)
	BEGIN
      -- Let's remember the current salary of the employee in `SALARY_CUR`
      DECLARE SALARY_CUR INT;
        SET SALARY_CUR=(SELECT s.salary FROM salaries s WHERE s.emp_no=P_EMP_NO 
                                                         AND s.to_date > CURDATE());
       -- let's ensure the employee exists               
	    IF P_EMP_NO NOT IN (SELECT e.emp_no FROM employees e)
	       THEN
		       SIGNAL SQLSTATE '45000' -- returns general purpose error
               SET MESSAGE_TEXT = 'emp_no does not exist';
		END IF;
           
        START TRANSACTION;
        -- So, let's close the current salary for the employee
            UPDATE salaries s
              SET s.to_date = CURDATE()
		    WHERE s.emp_no = P_EMP_NO
                 AND s.to_date > CURDATE();
           
	        
		-- Let's add a new salary (P_SALARY OR SALARY_CUR) for the employee
          INSERT INTO salaries (emp_no, salary, from_date, to_date)
          VALUES(P_EMP_NO, IF(P_SALARY<>0,P_SALARY,SALARY_CUR), CURDATE(), '9999-01-01');
        
        COMMIT;
        SELECT 'The transaction has finished successfully';      
       
    END;
$$
DELIMITER ;

-- Let`s test EMP_TRANSFER procedure with valid values
CALL EMP_TRANSFER(10002,36000);
CALL EMP_TRANSFER(10003,0);

-- Let`s test EMP_TRANSFER procedure with invalid values for the emp_no column
CALL EMP_TRANSFER(102,36000);


/*
3. Create a procedure for dismissing an employee, which involves deleting their entry 
from the 'employees' table and closing the historical records in the 'dept_emp',
 'salaries', and 'titles' tables. If a non-existing employee number is provided, 
 display an error with the appropriate message.
*/

SET SQL_SAFE_UPDATES = 0;

DROP PROCEDURE IF EXISTS DELETE_EMPLOYEE;
DELIMITER $$
CREATE PROCEDURE DELETE_EMPLOYEE(IN P_EMP_NO INT)
	BEGIN
       -- let's ensure the employee exists
       IF P_EMP_NO NOT IN (SELECT e.emp_no FROM employees e)
	       THEN
		       SIGNAL SQLSTATE '45000' -- returns general purpose error
               SET MESSAGE_TEXT = 'emp_no does not exist';
           END IF;
           
	 
	 START TRANSACTION;
       -- let`s delete the employee
        /*DELETE  FROM employees
        WHERE emp_no=P_EMP_NO;*/
        
        -- let's close the current department for the employee
        UPDATE dept_emp de
           SET de.to_date = CURDATE()
		 WHERE de.emp_no = P_EMP_NO
           AND de.to_date > CURDATE();
           
	   -- So, let's close the current salary for the employee
		UPDATE salaries s
           SET s.to_date = CURDATE()
		 WHERE s.emp_no = P_EMP_NO
           AND s.to_date > CURDATE();
           
          -- let`s close the current title for the employee
          UPDATE titles t
           SET t.to_date = CURDATE()
		 WHERE t.emp_no = P_EMP_NO
           AND t.to_date > CURDATE(); 
	       
	  COMMIT;
        SELECT 'The transaction has finished successfully';      
       
    END;
$$
DELIMITER ;

-- Let`s test DELETE_EMPLOYEE procedure with valid values
CALL DELETE_EMPLOYEE(10002);

-- Let`s test DELETE_EMPLOYEE procedure with invalid values for the emp_no column
CALL DELETE_EMPLOYEE(102);


/*
4. Create a function that displays the current salary for an employee.
*/
DROP FUNCTION IF EXISTS GET_CUR_SALARY;
DELIMITER //
CREATE FUNCTION GET_CUR_SALARY (P_EMP_NO INT)
	RETURNS VARCHAR(50) DETERMINISTIC
	BEGIN
		DECLARE V_SALARY INT;
        
         -- let's ensure the employee exists
       IF P_EMP_NO NOT IN (SELECT e.emp_no FROM employees e)
	       THEN
		       SIGNAL SQLSTATE '45000' -- returns general purpose error
               SET MESSAGE_TEXT = 'emp_no does not exist';
	   END IF;
       
		-- let`s select current salary of the employee
	    SELECT S.SALARY
		  INTO V_SALARY
		 FROM SALARIES S
		WHERE S.TO_DATE > CURRENT_DATE()
                AND S.EMP_NO = P_EMP_NO;
	
    RETURN V_SALARY;
END; //
DELIMITER ;

-- Let`s test GET_CUR_SALARY function with valid values
SELECT GET_CUR_SALARY(10004) `CUR_SALARY`;
  
-- Let`s test GET_CUR_SALARY function with invalid values for the emp_no column  
SELECT GET_CUR_SALARY(1004) `CUR_SALARY`;