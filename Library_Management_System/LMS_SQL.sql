-- Librabry Management System (LMS) Project

-- Creating branch table
DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
					branch_id VARCHAR(10) PRIMARY KEY,
					manager_id VARCHAR(10),
					branch_address VARCHAR(50),
					contact_no VARCHAR(15)
					);

-- Creating Employess table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
					emp_id VARCHAR(10) PRIMARY KEY,
					emp_name VARCHAR(25),
					position VARCHAR(25),
					salary INT,
					branch_id VARCHAR(20) -- FK
					);

-- Creating books table
DROP TABLE IF EXISTS books;
CREATE TABLE books(
					isbn VARCHAR(25) PRIMARY KEY,
					book_title VARCHAR(75),
					category VARCHAR(25),
					rental_price FLOAT,
					status VARCHAR(25),
					author VARCHAR(35),
					publisher VARCHAR(55)
					);

-- Creating members table
DROP TABLE IF EXISTS members;
CREATE TABLE members(
					member_id VARCHAR(10) PRIMARY KEY,
					member_name VARCHAR(35),
					member_address VARCHAR(50),
					reg_date DATE
					);

-- Creating issue_status table
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status(
					issued_id VARCHAR(10) PRIMARY KEY,
					issued_member_id VARCHAR(10), -- FK
					issued_book_name VARCHAR(75),
					issued_date DATE,
					issued_book_isbn VARCHAR(25), -- FK
					issued_emp_id VARCHAR(10) -- FK
					);

-- Creating return_status table
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
					return_id VARCHAR(10) PRIMARY KEY,
					issued_id VARCHAR(10),
					return_book_name VARCHAR(75),
					return_date DATE,
					return_book_isbn VARCHAR(20)
					);				

-- FOREIGN KEY
ALTER TABLE  issued_status
ADD CONSTRAINT fk_member
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

-- FOREIGN KEY
ALTER TABLE  issued_status
ADD CONSTRAINT fk_book_isbn
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

-- FOREIGN KEY
ALTER TABLE  issued_status
ADD CONSTRAINT fk_emp_id
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

-- FOREIGN KEY
ALTER TABLE  employees
ADD CONSTRAINT fk_branch_id
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);

-- FOREIGN KEY
ALTER TABLE  return_status
ADD CONSTRAINT fk_issued_id
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);

-- CRUD Operations
-- Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES ( '978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Update exixting member address
UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

-- Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id = 'IS121';
SELECT * FROM issued_status;

-- Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT issued_book_name FROM issued_status
WHERE issued_emp_id = 'E101';

-- List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_member_id, count(*) AS num_of_books
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*
);

-- Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
CREATE TABLE book_issued_summary AS
SELECT b.isbn, b.book_title, count(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b 
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

-- Data Analysis and findings
-- Retrieve all book from category classic
SELECT * FROM books
WHERE category = 'Classic';

-- Total rental income by category
SELECT b.category, SUM(b.rental_price) AS rental_income, COUNT(*)
FROM issued_status ist
JOIN books b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.category 
ORDER BY rental_income DESC;

-- List of members in last 180 days
SELECT * FROM members
WHERE reg_date >= current_date - INTERVAL '180 days';

--List Employees with Their Branch Manager's Name and their branch details(use self join)
SELECT e.emp_name, b.branch_id, b.manager_id, b.branch_address, b.contact_no,e2.emp_name as Manager_Name
FROM employees e
JOIN branch b
ON e.branch_id = b.branch_id
JOIN employees as e2
ON e2.emp_id = b.manager_id;

-- Create a Table of Books with Rental Price Above a Certain Threshold
DROP TABLE IF EXISTS expensive_book;
CREATE TABLE expensive_book AS
SELECT * FROM books
WHERE rental_price > 7.00;
SELECT * FROM expensive_book;

-- Retrieve the list of books not yet returned
SELECT issued_id, issued_book_name 
FROM issued_status
WHERE issued_id NOT IN (
				SELECT issued_id 
				FROM return_status);	
				
-- Retrieve the list of books not yet returned using LEFT join
SELECT * FROM issued_status AS ist
LEFT JOIN return_status AS rst
ON ist.issued_id = rst.issued_id
WHERE rst.issued_id IS NULL
ORDER BY ist.issued_id;

-- Identify Members with Overdue Books ( as data is old using MAX(issue date))
WITH params AS(SELECT MAX(issued_date) AS as_of_date FROM issued_status)
SELECT 
	ist.issued_member_id AS member_id,
	m.member_name,
	b.book_title,
	ist.issued_date,
	DATE_PART(
        'day',
        p.as_of_date - (ist.issued_date + INTERVAL '30 days')
    )::int AS days_overdue
FROM issued_status ist
JOIN members m ON m.member_id = ist.issued_member_id
JOIN books b ON b.isbn = ist.issued_book_isbn
LEFT JOIN return_status rst ON rst.issued_id = ist.issued_id
CROSS JOIN params p
WHERE rst.issued_id IS NULL
AND p.as_of_date > (ist.issued_date + INTERVAL '30 days' );

-- Create a query that generates a performance report for each branch, showing the number of books issued, 
-- the number of books returned, and the total revenue generated from book rentals.
-- Branch performance report
DROP TABLE IF EXISTS branch_report;
CREATE TABLE branch_report AS
SELECT
	br.branch_id,
	br.manager_id,
	COUNT(ist.issued_id) AS number_book_issued,
	COUNT(rst.return_id) AS number_book_returned,
	SUM(b.rental_price) as total_revenue
FROM issued_status ist
JOIN employees e ON e.emp_id = ist.issued_emp_id
JOIN branch br ON br.manager_id = ist.issued_emp_id
LEFT JOIN return_status rst ON ist.issued_id = rst.issued_id
JOIN books b ON ist.issued_book_isbn = b.isbn
GROUP BY br.branch_id, br.manager_id;
SELECT * FROM branch_report;

-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, 
-- number of books processed, and their branch.
SELECT 
	e.emp_name,
	br.branch_id,
	COUNT(ist.issued_id) AS no_book_issued
FROM issued_status ist
JOIN employees e ON e.emp_id = ist.issued_emp_id
JOIN branch br ON e.branch_id = br.branch_id
GROUP BY e.emp_name,br.branch_id
ORDER BY no_book_issued DESC
LIMIT 3;