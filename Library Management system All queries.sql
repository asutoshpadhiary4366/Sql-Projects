--LMS--Library Management System
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
	emp_name varchar(30),
	position	varchar(20),
	salary	int,
	branch_id varchar(10)
);
drop table Employee;
alter table Employee
alter column salary type float;
--Creating Books Table--
create table if not exists Books
(
	isbn varchar(20) primary key,	
	book_title	varchar(80),
	category	varchar(10),
	rental_price	float,
	status	varchar(20),
	author	varchar(35),
	publisher varchar(55)
);
--changing the data type of category--
Alter table Books
alter column category type varchar(20);
--Creating Members table--
drop table members;
create table if not exists Members
(
	member_id varchar(10) primary key,
	member_name varchar(80),
	member_address	varchar(75),
	reg_date date
)
 --Creating Issued_Status table--
create table if not exists Issued_Status
(
		issued_id varchar(10) primary key,
	issued_member_id varchar(10),
	issued_book_name varchar(75),
	issued_date date,
	issued_book_isbn varchar(50),
	issued_emp_id varchar(10)
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


INSERT INTO Members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');


INSERT INTO Issued_Status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');

INSERT INTO Return_Status(return_id, issued_id, return_date) 
VALUES
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');

--Project Tasks---
--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee'
, 'J.B. Lippincott & Co.')"--

insert into books values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee'
, 'J.B. Lippincott & Co.');
select * from Books;


--Task 2.Update an existing members address of an member--
update Members
set member_address='noida 1st sector'
where member_id='C101';
select * from  Members;

--task 3.Delete a record from the Issued_Status Table
--Objective:Delete the Record with Issued_id='IS110'
select * from Issued_Status;
delete from Issued_status
where issued_id='IS122';--This cannot be deleted as it has the row in the return_status as 
--a foreign key so we should delete by watching the retrun_status table


-- Task 4: Retrieve All Books Issued by a Specific Employee -- 
--Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from Issued_Status 
where issued_emp_id='E101';

-- Task 5: List Members Who Have Issued More Than One Book -- 
--Objective: Use GROUP BY to find members who have issued more than one book.
select I.issued_emp_id,E.emp_name
from Issued_status as I
join Employee as E
on I.issued_emp_id=E.emp_id
group by I.issued_emp_id,E.Emp_name
having count(issued_emp_id)>1;

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and --
--total book_issued_cnt**
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

select * from Book_cnt;
-- Task 7. Retrieve All Books in a Specific Category:
select 
category,Book_title 
from 
	Books 
where 
	category='Classic';
-- Task 8: Find Total Rental Income by Category:
select 
	Books.category,
	sum(Books.rental_price)as rental_price_per_category,
	count(*)
from Books
join Issued_Status
on Books.isbn=Issued_Status.issued_book_isbn
group by Books.category;
-- Task 9: List Members Who Registered in the Last 180 Days:
Insert into Members values('12a','Asutosh','123Bangelore street','2024-06-01');
select * from Members;
select member_id,member_name
from Members
where reg_date>= Current_date - interval '180 days' 
-- task 10 List Employees with Their Branch Manager's Name and their branch details:
select * from Branch;
select * from Employee;
select e.*,
	b.manager_id,
	e1.emp_name as manager_name
from
 	Employee as e
join Branch as b
on b.branch_id=e.branch_id
join Employee as e1
on b.manager_id=e1.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
select * from Books;
create table Books_above_seven
as
select * from Books 
where rental_price>7;
select *  from Books_above_seven;

-- Task 12: Retrieve the List of Books Not Yet Returned

select 
	distinct Ist.issued_book_name
from Issued_status as Ist
left join return_Status as rs
on Ist.issued_id=rs.Issued_id
where rs.return_id is null;

----Advance Sql Queries-----
/*Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue*/

/*Approach--
Issued_status == Members ==Books == return_status
*/
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

/*    
Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are 
returned (based on entries in the return_status table).
*/
select * from Return_status;
select * from Issued_Status;

--Stored Procedures---
create or replace procedure add_return_records(p_return_id varchar(10),p_issued_id varchar(10))
											  
language plpgsql
as $$

declare
	v_isbn varchar(50);
	book_name varchar(80);
begin
	insert into return_status(return_id,issued_id,return_date)
	values
	(p_return_id,p_issued_id,current_date);
	
	select
		issued_book_isbn,issued_book_name
	into
		 v_isbn,book_name
	from Issued_Status
	where issued_id=p_issued_id;
	
	Update books
	set status ='Yes'
	where isbn=v_isbn;
	
	Raise Notice 'Thank You for returning the book: %',book_name;
end;
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


--Calling Procedures--
call add_return_records('RS145','IS135');


/*
Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of 
books issued, the number of books returned, and the total revenue generated from book rentals.
*/
select 
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

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
--containing members who have issued at least one book in the last 6 months.
create table Active_Members
as 
select 
		distinct m.*
from members as m
join Issued_status as ist
on ist.issued_member_id = m.member_id
where 
	ist.issued_date >= current_date-interval '6 month' ;


select *  from active_members;


-- -- Task 17: Find Employees with the Most Book Issues Processed
-- -- Write a query to find the top 3 employees who have processed the most book 
-- issues. Display the employee name, number of books processed, and their branch.


select 
e.emp_name,
count(ist.issued_id) as books_processed,
b.*
from employee as e
join Issued_Status as ist
on ist.issued_emp_id = e.emp_id
join Branch as b
on b.branch_id = e.branch_id
group by 1,3;




/*
Task 19: Stored Procedure Objective: 
Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book 
in the library based on its issuance. 
The procedure should function as follows: 
The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). 
If the book is available, it should be issued, and the status in the books 
table should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an 
error message indicating that the book is currently not available.
*/
select * from Books;


Create or replace procedure 
	Issue_book(p_issued_id varchar(10),p_issued_member_id varchar(10),
			   p_issued_book_isbn varchar(50),p_isuued_emp_id varchar(10))
language plpgsql
as $$
declare
--All the variables declared here
v_status varchar(20);
begin
-- all the function written here
--checking if book is available 'Yes'
select 
	status
into
	v_status
from books
where isbn= p_issued_book_isbn;

if v_status='yes' then
	insert into Issued_status
	(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
	values 
	(p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

	update 
		books 
	set 
		status='no' 
	where 
		isbn =p_issued_book_isbn;
	RAISE NOTICE 'Book records added successfully for book isbn : %', p_issued_book_isbn;


    ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;

end
$$;







