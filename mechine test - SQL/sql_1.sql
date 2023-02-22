-- data base creation
create database test1;

-- connect to database
\c test1;

-- create relation / tables
create table tbl_stock(pk_int_stock_id serial primary key,vchr_name varchar(20),int_quantity int,int_price int);

-- created relation showing 
\d tbl_stock;

--  Alter tbl_stock to change the data type of "int_price" to float
alter table tbl_stock alter column int_price type float;

--  create the table 'tbl_supplier'
create table tbl_supplier(pk_int_supplier_id serial primary key,vchr_supplier_name varchar(25));

-- relation showing
\d tbl_supplier;

-- add column 
alter table tbl_stock add fk_int_supplier int;

-- foreign key adding 
alter table tbl_stock add foreign key(fk_int_supplier) references tbl_supplier(pk_int_supplier_id);

-- Create a table named 'tbl_dept'
create table tbl_dept(pk_int_dept_id serial primary key,vchr_dept_name varchar);

-- Create a table named 'tbl_classes'
create table tbl_classes(pk_int_class_id serial primary key,vchr_class_name varchar,fk_int_dept_int int,foreign key(fk_int_dept_int) references tbl_dept(pk_int_dept_id) on delete cascade on update cascade);

-- Create a table named 'tbl_enrollment'   
create table tbl_enrollment(pk_int_enrollment_id serial primary key,int_count int,fk_int_class_id int, foreign key (fk_int_class_id) references tbl_classes(pk_int_class_id)on delete cascade on update cascade);

-- Alter table named 'tbl_classes' and add unique constraint to 'vchr_class_name'
alter table tbl_classes add unique(vchr_class_name);

-- Alter table named 'tbl_dept' to add a column called 'vchr_dept_description' with varchar type
alter table tbl_dept add column vchr_dept_discription varchar;

-- Insert Values into 'tbl_supplier
insert into tbl_supplier(vchr_supplier_name)Values('Logitech'),('Samsung'),('Iball'),('LG'),('Creative');

-- table show tbl_supplier
select * from tbl_supplier;




-- Machine test - SQL-2




-- Insert values into 'tbl_stock' as shown in the expected output image
 insert into tbl_stock(vchr_name,int_quantity,int_price,fk_int_supplier)values('Mouse',10,500,1),
                                                                              ('Keyboard',5,450,3),
                                                                              ('Modem',10,1200,2),
                                                                              ('Memory',100,1500,5),
                                                                              ('Headphone',50,750,4),
                                                                              ('Memory',2,3500,4);

-- updation the price values in tbl_stock table
update tbl_stock set int_price = 501.5 where pk_int_stock_id = 1;

update tbl_stock set int_price = 451.5 where pk_int_stock_id = 2;
update tbl_stock set int_price = 1201.5 where pk_int_stock_id = 3;
update tbl_stock set int_price = 1501.5 where pk_int_stock_id = 4;
update tbl_stock set int_price = 751.5 where pk_int_stock_id = 5;
update tbl_stock set int_price = 3501.5 where pk_int_stock_id = 6;

-- From “tbl_stock” , List only the items that are more than Rs.1000/- per unit int_price
select * from tbl_stock where int_price > 1000;

-- From “tbl_stock” , List all the items sorted alphabetically
-- we can use asc and desc
select * from tbl_stock order by vchr_name;

-- 3 row printing
select * from tbl_stock order by vchr_name limit 3;

-- tbl_stock last 3 rows
select * from tbl_stock order by vchr_name desc limit 3;

-- From “tbl_stock” ,List all the items with their extended price (int_quantity * int_price)
select vchr_name,int_quantity,int_price, int_price*int_quantity as total_amount from tbl_stock;

-- delete a row
delete from tbl_stock where fk_int_supplier =  5;

-- insert values in tbl_dept
insert into tbl_dept(vchr_dept_name,vchr_dept_discription)values('Computer Sience','CS');
insert into tbl_dept(vchr_dept_name,vchr_dept_discription)values('Electronics','EC'),('Commerce','CC'),('Arts','AR');



-- mechine test - SQL - 3


-- total cost qty*price=total 
select sum(int_quantity*int_price) as totalcost from tbl_stock;

-- total count of product (sum of qty)
select sum(int_quantity) as total_no_product from tbl_stock;

-- 4th
select count(distinct vchr_name)as items from tbl_stock;

-- 5th MAX 
select vchr_name,int_price from tbl_stock where int_price =(select max(int_price) from tbl_stock);

-- 6th
-- insert into tbl_classes(vchr_class_name,fk_int_dept_int)values('CS100',1),('CS1001',1),('CS102',1),('CS103',1),('EC200',2),('CC300',3),('AT400',4);
-- Insert into tbl_enrollment(int_count,fk_int_class_id)values(40,1),(15,2),(10,3),(12,4),(60,2),(14,6),(200,7);
select sum(int_count)as total_enrollment from tbl_enrollment;

-- 7th
select count(distinct vchr_class_name) as no_of_classes from tbl_classes;

-- 8th
delete from tbl_supplier where vchr_supplier_name = 'Creative';


-- 9th
select (vchr_name,int_price) as product_price from tbl_stock;




-- 10th
-- create table tb_student(EnRl_No int,Roll_NO int primary key,name varchar(40),city varchar(50),mobile bigint,DOb date);
-- insert into tb_student(EnRl_No,Roll_NO,name,city,mobile,dob)values(11,2,'akhil','delhi',98756579,'12-01-1986'),
--                                                                 (6,4,'maya','bangalore',98734534,'12-11-1987'),
--                                                                 (1,8,'anoop','bangalore',93456535,'22-12-1990'),
--                                                                 (20,1,'paul','cochin',96754555,'13-3-1991'),
--                                                                 (3,5,'sandeep','delhi',84865644,'14-06-1993');

-- create table tb_grade(Roll_NO int,course varchar(40),grade varchar(5),
--                     foreign key (Roll_NO) references tb_student(Roll_NO) on delete cascade on update cascade);
insert into tb_grade(Roll_NO,course,grade)values(2,'C','A'),(2,'Java','B'),(1,'C','B'),(1,'Java','A'),(4,'PHP','A'),(4,'Java','A'),(4,'C','B'),(8,'Java','B'),(5,'PHP','A'),(5,'Java','D');
select name,course from tb_student inner join tb_grade on tb_student.Roll_NO = tb_grade.Roll_NO where tb_grade.grade = 'A';

-- 11th
select count(tb_grade.grade) as B_grade_students from tb_student inner join tb_grade on tb_student.Roll_NO = tb_grade.Roll_NO where tb_grade.grade = 'B';

-- 12th
select tb_student.name,tb_student.roll_no,count(tb_grade.grade) as course_applied from tb_student inner join tb_grade on tb_student.Roll_NO = tb_grade.Roll_NO group by tb_student.name,tb_student.Roll_NO;


-- 13th
select tb_student.name,tb_grade.course,tb_student.city from tb_student inner join tb_grade on tb_student.roll_no = tb_grade.roll_no where tb_grade.course ='Java' and tb_student.city='bangalore';

-- 14th
select distinct tb_student.name,tb_grade.course from tb_student,tb_grade where tb_student.name like 'a%' order by tb_student.name;

-- 15th
select name,age(current_date,dob)from tb_student;

-- 16th
select name,to_char(dob,'dd-mon-yyyy')as date_of_birth from tb_student;