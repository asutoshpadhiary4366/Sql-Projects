# Library Management System using SQL

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `Library_Management_System`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.



## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup
https://github.com/asutoshpadhiary4366/Sql-Projects/blob/main/Library%20Management%20System%20Database%20setup.png

- **Database Creation**: Created a database named `Library_Management_System`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
--Library Management System
--Creating Branch Table--
CREATE TABLE if not exists Branch
(
	branch_id	varchar(10) primary key,
	manager_id	varchar(10),
	branch_address	varchar(50),
	contact_no varchar(12)
);
--createing employee table--
create table if not exists Employee
(
	emp_id	varchar(10) primary key,
	emp_name    varchar(30),
	position	varchar(20),
	salary	int,
	branch_id   varchar(10)
);
drop table Employee;
alter table Employee;
alter column salary type float;
--Creating Books Table--
create table if not exists Books
(
	isbn             varchar(20) primary key,	
	book_title	     varchar(80),
	category	     varchar(10),
	rental_price     float,
	status	     varchar(20),
	author	     varchar(35),
	publisher        varchar(55)
);
--changing the data type of category--
Alter table Books
alter column category type varchar(20);
--Creating Members table--
drop table members;
create table if not exists Members
(
	member_id        varchar(10) primary key,
	member_name      varchar(80),
	member_address   varchar(75),
	reg_date         date
)
 --Creating Issued_Status table--
create table if not exists Issued_Status
(
            issued_id            varchar(10) primary key,
	issued_member_id     varchar(10),
	issued_book_name     varchar(75),
	issued_date          date,
	issued_book_isbn     varchar(50),
	issued_emp_id        varchar(10)
);
--creating Return status table--
create table if not exists Return_Status
(
	return_id varchar(10) primary key,
	issued_id varchar(10),	
	return_book_name varchar(75),
	return_date date,
	return_book_isbn varchar(20)
);
--Creating foreign keys--
Alter table Return_Status
Add constraint fk_issued_status
foreign key(issued_id)
references Issued_status(Issued_id);

Alter table Issued_Status
Add constraint fk_members
foreign key(issued_member_id)
references Members(member_id);


Alter table Issued_Status
Add constraint fk_employee
foreign key(issued_emp_id)
references Employee(emp_id);
Alter table Issued_Status Drop constraint fk_employee;

Alter table Issued_Status
Add constraint fk_books
foreign key(issued_book_isbn)
references Books(isbn);


Alter table Employee
Add constraint fk_branch
foreign key (branch_id)
references	Branch(branch_id);
--As I am Using Postgres so i should insert the csv files through the tabels insert option--
```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO Books
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;
```
**Task 2: Update an Existing Member's Address**

```sql
UPDATE Members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM Issued_Status
WHERE   issued_id =   'IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
select I.issued_emp_id,E.emp_name
from Issued_status as I
join Employee as E
on I.issued_emp_id=E.emp_id
group by I.issued_emp_id,E.Emp_name
having count(issued_emp_id)>1;
```

### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
Create table Book_cnt
As
select
	B.isbn,
	B.book_title,
	count(I.issued_book_isbn)as count_of_issued_books
from Books as B
join
	Issued_status as I
on B.isbn=I.issued_book_isbn
group by 1,2;
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
SELECT * FROM Books
WHERE category = 'Classic';
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
select 
	Books.category,
	sum(Books.rental_price)as rental_price_per_category,
	count(*)
from Books
join Issued_Status
on Books.isbn=Issued_Status.issued_book_isbn
group by Books.category;
```

9. **List Members Who Registered in the Last 180 Days**:
```sql
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
select e.*,
	b.manager_id,
	e1.emp_name as manager_name
from
 	Employee as e
join Branch as b
on b.branch_id=e.branch_id
join Employee as e1
on b.manager_id=e1.emp_id;
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
CREATE TABLE expensive_books AS
SELECT * FROM Books
WHERE rental_price > 7.00;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
select 
	distinct Ist.issued_book_name
from Issued_status as Ist
left join return_Status as rs
on Ist.issued_id=rs.Issued_id
where rs.return_id is null;
```

## Advanced SQL Operations

**Task 13: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

```sql
select 
	m.member_id,
	m.member_name,
	b.book_title,
	ist.issued_date,
	current_date-ist.issued_date as overdue
from Issued_Status as ist
join 
	Members as  m
on 
	ist.issued_member_id = m.member_id
join 
	Books as b
on ist.issued_book_isbn = b.isbn
left join 
	Return_Status as rs
on ist.issued_id = rs.issued_id
where 
	rs.return_date is null
	And
	current_date-ist.issued_date >30
order by m.member_id;
```


**Task 14: Update Book Status on Return**  
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).


```sql

CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10), p_book_quality VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
    v_isbn VARCHAR(50);
    v_book_name VARCHAR(80);
    
BEGIN
    -- all your logic and code
    -- inserting into returns based on users input
    INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
    VALUES
    (p_return_id, p_issued_id, CURRENT_DATE, p_book_quality);

    SELECT 
        issued_book_isbn,
        issued_book_name
        INTO
        v_isbn,
        v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    RAISE NOTICE 'Thank you for returning the book: %', v_book_name;
    
END;
$$


-- Testing FUNCTION add_return_records

issued_id = IS135
ISBN = WHERE isbn = '978-0-307-58837-1'

SELECT * FROM books
WHERE isbn = '978-0-307-58837-1';

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM return_status
WHERE issued_id = 'IS135';

-- calling function 
CALL add_return_records('RS138', 'IS135', 'Good');

-- calling function 
CALL add_return_records('RS148', 'IS140', 'Good');

```




**Task 15: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

```sql
CREATE TABLE branch_reports
ASselect 
	b.branch_id,
	b.manager_id,
	count(ist.issued_id) as book_count,
	count(rs.issued_id) as returned_book_count,
	sum(bk.rental_price) as total_revenue
from Issued_status as ist
join 
	employee as e
on e.emp_id = ist.issued_emp_id
join 
	Branch as b
on b.branch_id = e.branch_id
join 
	books as bk
on bk.isbn = ist.issued_book_isbn
left join return_status as rs
on rs.issued_id = ist.issued_id
group by 1,2;

SELECT * FROM branch_reports;
```

**Task 16: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

```sql

create table Active_Members
as 
select 
		distinct m.*
from members as m
join Issued_status as ist
on ist.issued_member_id = m.member_id
where 
	ist.issued_date >= current_date-interval '2 month' ;


select *  from active_members;
```


**Task 17: Find Employees with the Most Book Issues Processed**  
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

```sql
SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) as no_book_issued
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1, 2
```
**Task 18: Stored Procedure**
Objective:
Create a stored procedure to manage the status of books in a library system.
Description:
Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows:
The stored procedure should take the book_id as an input parameter.
The procedure should first check if the book is available (status = 'yes').
If the book is available, it should be issued, and the status in the books table should be updated to 'no'.
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.

```sql

CREATE OR REPLACE PROCEDURE issue_book(p_issued_id VARCHAR(10), p_issued_member_id VARCHAR(30), p_issued_book_isbn VARCHAR(30), p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
-- all the variabable
    v_status VARCHAR(10);

BEGIN
-- all the code
    -- checking if book is available 'yes'
    SELECT 
        status 
        INTO
        v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN

        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES
        (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        UPDATE books
            SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        RAISE NOTICE 'Book records added successfully for book isbn : %', p_issued_book_isbn;


    ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;
END;
$$

-- Testing The function
SELECT * FROM books;
-- "978-0-553-29698-2" -- yes
-- "978-0-375-41398-8" -- no
SELECT * FROM issued_status;

CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

SELECT * FROM books
WHERE isbn = '978-0-375-41398-8'

```

## Reports

- **Database Architecture**: Comprehensive overview of table structures and relational mappings..
- **Data Analyitics**: In-depth analysis of book categories, employee compensation, member registration trends, and book issuance patterns.
- **Executive Summaries**: Concise aggregation of data highlighting high-demand books and evaluating employee performance metrics.

## Conclusion

This project showcases the effective application of advanced SQL techniques in the development and management of a robust library management system. From database design to sophisticated data manipulation and querying, it lays a strong foundation for efficient data management and insightful analysis.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone 
   ```

2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

## Author - Asutosh Padhiary

This project showcases SQL skills essential for database management and analysis. 


Thank you for your interest in this project!
