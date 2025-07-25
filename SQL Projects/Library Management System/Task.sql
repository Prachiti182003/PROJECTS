---PROJECT TASKS---

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;
---Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books (isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

---Task 2: Update an Existing Member's Address

UPDATE members
SET member_name ='Riya Kadam'
WHERE member_id ='C101';
SELECT * FROM members;

---Task 3: Delete a Record from the Issued Status Table
--Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status;
DELETE FROM issued_status
WHERE issued_id ='IS125'

---Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id ='E101';

----Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
issued_emp_id,
COUNT(issued_id) AS total_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT (issued_id) >1

--CTAS (Create Table As Select)

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE book_counts
AS
SELECT 
b.isbn,  --select this 2 columns from bk table
b.book_title,
COUNT(ist.issued_id) as no_issued --ID for each time a book was issued.
FROM books as b
JOIN --We are connecting the books table to the issued_status table.Only match rows where the book's ISBN in books matches the issued book's ISBN in issued_status
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2--This groups the result by the first and second columns in the SELECT:1 = b.isbn2 = b.book_title.So, it will count how many times each book was issued.

--Data Analysis & Findings

--Task 7 :Retrieve All Books in a Specific Category

SELECT * FROM books
WHERE category = 'Classic';

--Task 8: Find Total Rental Income by Category

SELECT 
b.category,
SUM(b.rental_price),
COUNT(*)
FROM issued_status as ist
JOIN
books as b
ON b.isbn =ist.issued_book_isbn
GROUP BY 1


--Task:9 List Members Who Registered in the Last 180 Days
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';

INSERT INTO members(member_id,member_name,member_address,reg_date)
VALUES 
('C120','Prachiti','127 Main st','2025-07-18'),
('C121','Renuka','144 Main st','2025-07-28');

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

--Task 12: Retrieve the List of Books Not Yet Returned

SELECT * FROM issued_status as ist
LEFT JOIN                 -----What is LEFT JOIN? (1) It returns all rows from the left table (issued_status).///(2)If there is a matching row in the right table (return_status), it brings it too.////(3)If there is no match, it fills the return_status columns with NULL.
return_status as rs
ON ist.issued_id=rs.issued_id
WHERE rs.return_id IS NULL;





