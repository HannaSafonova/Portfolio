/*1. Design a database for course management. The database contains the following entities:
a. students: student_no, teacher_no, course_no, student_name, email, birth_date.
b. teachers: teacher_no, teacher_name, phone_no.
c. courses: course_no, course_name, start_date, end_date.

● Partition the students table by years using the range mechanism on the birth_date field.
● In the students table, establish a composite primary key consisting of student_no and birth_date.
● Create an index on the students.email field.
● Establish a unique index on the teachers.phone_no field.*/

CREATE DATABASE IF NOT EXISTS course_management;
USE course_management;

CREATE TABLE IF NOT EXISTS students (
       student_no INT,
       teacher_no INT,
       course_no INT, 
       student_name VARCHAR(50),
       email VARCHAR(50),
       birth_date DATE,
       PRIMARY KEY(student_no,birth_date))
PARTITION BY RANGE (YEAR(birth_date)) (
      PARTITION p1 VALUES LESS THAN (2002),
      PARTITION p2 VALUES LESS THAN (2003),
      PARTITION p3 VALUES LESS THAN (2004),
      PARTITION p4 VALUES LESS THAN (2005),
      PARTITION p5 VALUES LESS THAN (2006),
      PARTITION p6 VALUES LESS THAN (2007),
      PARTITION p7 VALUES LESS THAN MAXVALUE      
      ) ;                       

CREATE TABLE IF NOT EXISTS teachers (
       teacher_no INT,
       teacher_name VARCHAR(50),
       phone_no VARCHAR(50)
)
 ;

CREATE TABLE IF NOT EXISTS courses (
       course_no INT,
       course_name VARCHAR(50),
       start_date DATE,
       end_date DATE
);

CREATE INDEX Index_email ON students(email);

CREATE UNIQUE INDEX Idxex_phone_no
ON teachers(phone_no);

/*2. Add test data at your discretion (7-10 rows) to our three tables.*/
INSERT INTO students (student_no, teacher_no, course_no, student_name, email, birth_date)
VALUES (1,1,1,'Іваницький Іван','Ivanivan@gmail.com','2005-10-02'),
       (2,1,2,'Баран Данило','BaranDanulo@gmail.com','2006-11-17'),
       (3,2,3,'Ігнатенко Володимир','Ignatvolod@gmail.com','2004-11-10'),
       (4,3,4,'Чебукін Юрій','ChebukUra@qmail.com','2003-05-16'),
       (5,3,4,'Льода Максим','LodaMax@gmail.com','2006-12-12'),
       (6,4,5,'Левицький Микола','Levickij@gmail.com','2002-06-07'),
       (7,5,6,'Макаренко Максим','MakarenkoMax@gmail.com','2001-04-05'),
       (8,6,7,'Кравченко Євген','Kravchenko@gmail.com','2005-10-02'),
       (9,6,7,'Потоцький Павло','PotocPavlo@gmail.com','2005-10-02'),
       (10,7,8,'Астрамович Ларіон','Astramovlar@gmail.com','2005-10-02')
       ;
INSERT INTO teachers (teacher_no, teacher_name, phone_no)
VALUES (1,'Сафонова М.С.','0665304725'),
       (2,'Цап В.В.','0995478236'),
       (3,'Вічна О.В.','0970475896'),
       (4,'Волошин А.Р.','0505836459'),
       (5,'Куценко С.А.','0993624187'),
       (6,'Карпець І.В.','0973625789'),
       (7,'Хлистун О.Ф.','0972345623')
       ;
INSERT INTO courses (course_no, course_name, start_date, end_date)
VALUES (1,'Теорія ймовірностей','2023-01-09','2023-06-30'),
       (2,'Вища математика','2023-01-09','2023-06-30'),
       (3,'Дискретна математика','2023-01-09','2023-06-30'),
       (4,'Математика','2022-09-01','2023-06-30'),
       (5,'Основи програмування','2022-09-01','2023-06-30'),
       (6,"Комп'ютерна графіка",'2023-01-09','2023-06-30'),
       (7,"Комп'ютерна логіка",'2023-01-09','2023-06-30'),
       (8,"Комп'ютерна електроніка",'2023-01-09','2023-06-30')
       ;
       /*SELECT * FROM students;
       SELECT * FROM teachers;
	   SELECT * FROM courses;*/
       
/*3. Display data for any year from the "students" table and record in the form of 
a comment the execution plan of the query, indicating that the query will 
be executed on a specific partition.*/
EXPLAIN
 SELECT *
  FROM students
WHERE birth_date BETWEEN '2005-01-01' AND '2005-12-31';

/*id, select_type, table,    partitions, type, possible_keys, key,  key_len, ref,  rows, filtered, Extra
'1', 'SIMPLE',     'students', 'p5',     'ALL',    NULL,      NULL,   NULL,  NULL, '4',   '25.00', 'Using where'*/

/*4. Retrieve the teacher's data using any phone number, and document the execution plan to show 
that the query will be executed using an index rather than the ALL method. Then, make the index on 
the "teachers.phone_no" field invisible and document the execution plan where the expected result 
is the ALL method. Finally, leave the index in a visible status.*/
EXPLAIN
 SELECT *
  FROM teachers
WHERE phone_no='0505836459';

/* id, select_type, table, partitions, type,     possible_keys,       key,           key_len,    ref,   rows, filtered, Extra
  '1', 'SIMPLE', 'teachers', NULL,    'const', 'Idxex_phone_no', 'Idxex_phone_no',    '203',   'const', '1', '100.00',  NULL*/

SHOW INDEXES FROM teachers;
/* Table, Non_unique, Key_name,    Seq_in_index, Column_name, Collation, Cardinality, Sub_part, Packed, Null, Index_type, Comment, Index_comment, Visible, Expression
 'teachers', '0',  'Idxex_phone_no',   '1',       'phone_no',    'A',        '7',       NULL,    NULL, 'YES',   'BTREE',     '',        '',         'YES',   NULL     */

ALTER TABLE teachers
ALTER INDEX Idxex_phone_no INVISIBLE;

SHOW INDEXES FROM teachers;
 /*Table, Non_unique, Key_name,   Seq_in_index, Column_name, Collation, Cardinality, Sub_part, Packed, Null, Index_type, Comment, Index_comment, Visible, Expression
'teachers', '0',   'Idxex_phone_no', '1',        'phone_no',    'A',        '7',         NULL,  NULL, 'YES', 'BTREE',       '',        '',         'NO',    NULL*/

EXPLAIN
 SELECT *
  FROM teachers
WHERE phone_no='0505836459';
/* id, select_type, table,  partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
   '1', 'SIMPLE', 'teachers', NULL,     'ALL', NULL,          NULL, NULL,  NULL, '7', '14.29', 'Using where'*/

ALTER TABLE teachers
ALTER INDEX Idxex_phone_no VISIBLE;

/*5. Intentionally create 3 duplicates in the 'students' table (add 3 more identical rows).*/
INSERT INTO students (student_no, teacher_no, course_no, student_name, email, birth_date)
VALUES (8,6,7,'Кравченко Євген','Kravchenko@gmail.com','2005-10-02'),
       (9,6,7,'Потоцький Павло','PotocPavlo@gmail.com','2005-10-02'),
       (10,7,8,'Астрамович Ларіон','Astramovlar@gmail.com','2005-10-02')
       ;
/*Error Code: 1062. Duplicate entry '8-2005-10-02' for key 'students.PRIMARY'	*/
-- deleting primary key
ALTER TABLE students DROP PRIMARY KEY;

/*6. Write a query that outputs rows with duplicates.*/

SELECT * 
  FROM (SELECT *, 
			   COUNT(*)OVER(PARTITION BY student_no, teacher_no, course_no, student_name, email, birth_date) dubbing
          FROM students) q
  WHERE dubbing > 1;