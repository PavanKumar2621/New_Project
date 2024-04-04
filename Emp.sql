use demo

create table Emp
(
	SNO int identity(1,1),
	Name varchar(20),
	Designation varchar(5),
	Joining_Date Date,
	Salary Decimal(7,2),
	Gender varchar(7),
	State varchar(30)
)
select * from Emp order by SNO
insert into Emp(name,Designation,joining_date,Salary,Gender,State) 
values('ram','dr.','2000-08-01',60000.0,'Male','jhf')
drop table emp
alter table Emp alter column SNo int identity(1,1)
delete from emp where state='rk'