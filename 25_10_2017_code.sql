create table t1(name varchar);
insert into t1(name) values('A'),('A'),('A'),('B'),('B');
create table t2(name2 varchar);
insert into t2(name2) values('A'),('A'),('B');

-- Query to display both table data horizontally
select 
    t.name,
    tk.name2 from
      (
        select t1.name,row_number() over (
          partition by name) as r1 
 from t1) 
t left join
 (select t2.name2,row_number() over (
   partition by name2) as r2
  from t2) tk on t.r1=tk.r2 and t.name=tk.name2;
  
  eg:Allow window functions to be used in sub-SELECTs that are within the arguments of an aggregate function (Tom Lane).
  select dept_id,min((select distinct first_value(emp_id)over(partition by dept_id) 
  from employee e1 where e1.dept_id = e.dept_id)) from employee e group by dept_id;

