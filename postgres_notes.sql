Window Functions
==============

We can use built in or user defined aggregate function as window function or we can use 
postgres window function such as rank(),dense_rank().

to divide rows into groups we use partition by clause.

row_number()
==========

assign serial number to rows in each partition.

select t.manager_name,t.name as emp_name,t.joining_date from
(select m.name as manager_name,e.name,e.joining_date,ROW_NUMBER() over (partition by m.name order by e.joining_date desc)
         from employee e 
         inner join employee m on 
           e.mgr_id=m.emp_id 
             group by m.name,e.name,e.joining_date) t where ROW_NUMBER=1;

rank()
====
Assign rankings within an ordered partition, If the values of two rows are same then it assign same ranking and skip the next rank.



select t.manager_name,t.name as emp_name,t.joining_date from
(select m.name as manager_name,e.name,e.joining_date,rank() over (partition by m.name order by e.joining_date desc)
         from employee e 
         inner join employee m on 
           e.mgr_id=m.emp_id 
             group by m.name,e.name,e.joining_date) t where rank=1;


dense_rank()
=========
Assigns rankings within an ordered partition..
But when the values of two rows get repeated it doesn’t skip the next ranking...instead continues ranking is performed.


To terminate query  or session
select *from pg_stat_activity
select *from pg_terminate_backend('21130');
select *from pg_cancel_backend('21130');




 
 PSQL Query to display emplyees who are not managers
 ***************************************************

  select e.name as emp_name,
  m.name as manager_name from
    employee e left join employee m on 
    e.emp_id=m.mgr_id where m.mgr_id is null limit 5;
    /*
    left joining with the same table gives all the matching result from the right table and the unmatched result will be marked
    as null hence in the above code we given a condition that mgr_id is null so it will print the cases when right table  mgr_id become null 
    ie when mgr_id is not matched with emp_id*/
    
 another way
 -----------   
    select emp_id,name from employee where emp_id 
    not in (select mgr_id from
            employee where mgr_id is not null) limit 5;

    /*the above code excludes manager ids which are not null ie the employees who are managers*/




 select emp_id,
 name from employee where 
 	emp_id not in 
 		(
 			select coalesce(mgr_id,0)from employee
 		);
 		/* the coalesce will substitute null value with zeroes hence we can exclude all the employees who are managers*/
            

 select emp_id,name from 
 	employee e where not exists
 	(  select mgr_id from employee m  where e.emp_id=m.mgr_id  )
 	/* the above code will exclude the table of managers*/


select e.name,e.emp_id from employee e 
left join employee m on e.emp_id=m.mgr_id except
(select e.name,e.emp_id from employee e 
left join employee m on e.emp_id=m.mgr_id
 where m.mgr_id is not null) order by emp_id;



 	Null Value property
 	===================

 	When we compare or add anything with NULL the result become NULL or unknown because NULL value is not defined.

    coalesce
    =========
    coalesce will return first of its argumenmt that are not null
    it will return null if all the argument are null.
    it is usually used to substitute some values to null.
    arguments to the right of the first non-null argument are not evaluated. 


    correlated subquery
    ===================
    In case of correlated sub query the inner query will re execute for each row in the outer query.
    ie the inner query is dependent on the outer query.

    inline subquerys
    ----------------
    In line subquerys are not dependent on the outer query.
    they will run independently. 


    nullif(arg1,arg2) 
    -----------------
    nullif function returns a null value if both arguments are same
    else it return the value of arg1;
