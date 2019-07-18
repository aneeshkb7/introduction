triggers
========

==>hin the trigger body, the OLD and NEW keywords enable you to access columns in the rows affected by a trigger
==>an INSERT trigger, only NEW.col_name can be used.
==> UPDATE trigger, you can use OLD.col_name to refer to the columns of a row before it is updated and NEW.col_name to refer to the columns of the row after it is updated.
==>a DELETE trigger, only OLD.col_name can be used; there is no new row.







INSERT INTO test 
SELECT emp_id,emp_name FROM employees
WHERE employees.emp_id IN (SELECT emp_id FROM employees where emp_id <100);


insert tnto test
select emp_id,emp_name from employees
where emp_id in(select emp_id from employees);




college=# college=# select s1.student_id,s1.student_name,d1.course_name from student s1 inner join department d1 on s1.dept_id=d1.department_id;




select s1.student_id,
	s1.student_name,
	d1.course_name,(select s_name from student inner join marks on student_id=stud_id inner join subjects on marks.subject_id=subjects.subject_id where marks.subject_id=1 and student_id=s1.student_id ),(select score from student inner join marks on student_id=stud_id inner join subjects on marks.subject_id=subjects.subject_id where marks.subject_id=1 and student_id=s1.student_id) from student s1 inner join department d1 on s1.dept_id=d1.department_id;




	sub1.s_name,m1.score from student s1 inner join department d1 on s1.dept_id=d1.department_id inner join marks m1 on m1.stud_id=s1.student_id inner join subjects sub1 on m1.subject_id=sub1.subject_id where m1.subject_id=1;



select s1.student_id,                                                                                                       	s1.student_name,                                                                                                                     d1.course_name,(select s_name from student inner join marks on student_id=stud_id inner join subjects on marks.subject_id=subjects.subject_id where marks.subject_id=1 and student_id=s1.student_id ),(select score from student inner join marks on student_id=stud_id where marks.subject_id=1 and student_id=s1.student_id) from student s1 inner join department d1 on s1.dept_id=d1.department_id where course_name='IT';







select s1.student_id,                                                                                                        s1.student_name,                                                                                                                     d1.course_name,(select s_name as sub1 from student inner join marks on student_id=stud_id inner join subjects on marks.subject_id=subjects.subject_id where marks.subject_id=(case when d1.department_id=20 then 1 when d1.department_id=21 then 1 when d1.separtment_id=22 then 1 when d1.department_id=23 then 2 end)  and student_id=s1.student_id ),(select score from student inner join marks on student_id=stud_id where marks.subject_id=1 and student_id=s1.student_id) from student s1 inner join department d1 on s1.dept_id=d1.department_id where course_name='IT';





-- FINAL


select s1.student_id,                                                                                                        		s1.student_name,                                                                                                                     d1.course_name,
(
	select s_name as sub1 from student 
		inner join marks on student_id=stud_id 
		inner join subjects on marks.subject_id=subjects.subject_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 1 
					when d1.department_id=21 then 1 
					when d1.department_id=22 then 1 
					when d1.department_id=23 then 2 end)
	       		and student_id=s1.student_id 
),
(
	select score from student 
		inner join marks on student_id=stud_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 1 
					when d1.department_id=21 then 1 
					when d1.department_id=22 then 1 
					when d1.department_id=23 then 2 end) 
			and student_id=s1.student_id),

(
	select s_name as sub2 from student 
		inner join marks on student_id=stud_id 
		inner join subjects on 	marks.subject_id=subjects.subject_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 2 
					when d1.department_id=21 then 2 
					when d1.department_id=22 then 5 
					when d1.department_id=23 then 4 end)  
			and student_id=s1.student_id ),
(
	select score from student 
		inner join marks on student_id=stud_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 2 
				when d1.department_id=21 then 2 
				when d1.department_id=22 then 5 
				when d1.department_id=23 then 4 end) 
			and student_id=s1.student_id),

(
	select s_name as sub3 from student 
		inner join marks on student_id=stud_id 
		inner join subjects on marks.subject_id=subjects.subject_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 3 
					when d1.department_id=21 then 3 
					when d1.department_id=22 then 6 
					when d1.department_id=23 then 6 end)  
			and student_id=s1.student_id ),
(
	select score from student 
		inner join marks on student_id=stud_id 
			where marks.subject_id=(
				case when d1.department_id=20 then 3 
					when d1.department_id=21 then 3 
					when d1.department_id=22 then 6 
					when d1.department_id=23 then 6 end) 
			and student_id=s1.student_id) 
	from student s1 
		inner join department d1 on s1.dept_id=d1.department_id;




-- final 2




	with s_details as (
	select
	s1.student_name,                                                                                                              		d1.course_name,
	rank() over(partition by student_name order by score,s_name desc) 
		from student s1 
			inner join department d1 on s1.dept_id=d1.department_id
			inner join marks m1 on s1.student_id=m1.stud_id 
			inner join subjects sub on m1.subject_id=sub.subject_id order by student_name,rank desc) 
			select s1.student_name,s1.course_name,
			
(select k1.s_name from s_details k1 where k1.student_id=s1.student_id and rank=3 group by k1.s_name,k1.student_id) as sub1,
(select k1.score from s_details k1 where k1.student_id=s1.student_id and rank=3 group by k1.score,k1.student_id),

(select k1.s_name from s_details k1 where k1.student_id=s1.student_id and rank=2 group by k1.s_name,k1.student_id) as sub2,	
(select k1.score from s_details k1 where k1.student_id=s1.student_id and rank=2 group by k1.score,k1.student_id),

(select k1.s_name from s_details k1 where k1.student_id=s1.student_id and rank=1 group by k1.s_name,k1.student_id) as sub3,	
(select k1.score from s_details k1 where k1.student_id=s1.student_id and rank=1 group by k1.score,k1.student_id) from s_details s1 	

	group by s1.student_name,s1.course_name,s1.student_id; 


-- final 3

with s_details as (
	select
	s1.student_id,                                                                                                         		s1.student_name,                                                                                                              		d1.course_name,
	sub.s_name,
	m1.score,
	rank() over(partition by student_name order by score,s_name desc) 
		from student s1 
			inner join department d1 on s1.dept_id=d1.department_id
			inner join marks m1 on s1.student_id=m1.stud_id 
			inner join subjects sub on m1.subject_id=sub.subject_id order by student_name,rank desc) 
			select s1.student_name,s1.course_name,s2.s_name from s_details s1 
				left join s_details s2 on s1.student_id=s2.student_id and s1.course_name=s2.course_name
				left join s_details s3 on s1.student_id=s3.student_id and s1.course_name=s3.course_name
				left join s_details s4 on s1.student_id=s3.student_id and s1.course_name=s3.course_name group by s1.student_name,s1.course_name,s2.s_name; 





--  jj





with s_details as (                                                                                                         select                                                                                                                               s1.student_id,                                                                                                          s1.student_name,                                                                                                               d1.course_name,    sub.s_name,                                                                                                                          m1.score,                                                                                                                            rank() over(partition by student_name order by score,s_name desc)                                                                    from student s1                                                                                                                      inner join department d1 on s1.dept_id=d1.department_id                                                                              inner join marks m1 on s1.student_id=m1.stud_id                                                                                      inner join subjects sub on m1.subject_id=sub.subject_id order by student_name,rank desc)                                             select s1.student_name ,s1.course_name,s2.s_name as sub1,s2.score,s3.s_name as sub2,s3.score,s1.s_name as sub3,s1.score

from s_details s1                     
left join s_details s2 on s1.student_id=s2.student_id and s1.course_name=s2.course_name                                              left join s_details s3 on s1.student_id=s3.student_id and s1.course_name=s3.course_name                                              left join s_details s4 on s1.student_id=s3.student_id and s1.course_name=s3.course_name 
where s2.rank=3 and s3.rank=2 and s1.rank=1 group by s1.student_name,s1.course_name,s2.s_name,s2.score,s3.s_name,s3.score,s1.s_name,s1.score order by s1.student_name;




with s_details as (                                                                                                         select                                                                                                                               s1.student_id,                                                                                                          s1.student_name,                                                                                                               d1.course_name,    sub.s_name,                                                                                                                          m1.score,                                                                                                                            rank() over(partition by student_name order by score desc,s_name desc)                                                                    from student s1                                                                                                                      inner join department d1 on s1.dept_id=d1.department_id                                                                              inner join marks m1 on s1.student_id=m1.stud_id                                                                                      inner join subjects sub on m1.subject_id=sub.subject_id order by student_name,rank desc)                                             select s1.student_name ,s1.course_name,
max(case when s2.rank = 1 then s2.s_name end) as sub1,
max(case when s2.rank = 1 then s2.score end) as score,
max(case when s2.rank = 2 then s2.s_name end) as sub1,
max(case when s2.rank = 2 then s2.score end) as score,
max(case when s2.rank = 3 then s2.s_name end) as sub1,
max(case when s2.rank = 3 then s2.score end) as score
from s_details s1                     
left join s_details s2 on s1.student_id=s2.student_id and s1.course_name=s2.course_name                                               
group by s1.student_name,s1.course_name 
 order by s1.student_name;









select s1.student_id,
        s1.student_name,
        c1.course_name,
        g1.year,
        g1.sem,
        g1.total_score,s_name,score,rank() over(partition by student_name order by sem,score desc,s_name desc) 
                from student s1 
                 	inner join courses c1 on c1.dp_id=s1.dept_id 
                        inner join grades g1 on s1.student_id=g1.stud_id
                        inner join marks m1 on m1.stud_id=s1.student_id 
			inner join subjects sub1 on                                                                  				sub1.subject_id=m1.subject_id and g1.sem=sub1.sem_id






----------











with stud_details as(select s1.student_id,
        s1.student_name,
        c1.course_name,
        g1.year,
        g1.sem,
        g1.total_score,s_name,score,rank() over(partition by student_name order by sem,score desc,s_name desc) 
                from student s1 
                 	inner join courses c1 on c1.dp_id=s1.dept_id 
                        inner join grades g1 on s1.student_id=g1.stud_id
                        inner join marks m1 on m1.stud_id=s1.student_id 
			inner join subjects sub1 on sub1.subject_id=m1.subject_id 
			and g1.sem=sub1.sem_id) 
			select student_id,student_name,course_name,
			year,sem,total_score,max(case when s2.rank = 1 then s2.s_name end) as sub1 from stud_details s1;





with stud_details as(
	
	select 
	s1.student_id,                                                                                  										s1.student_name,                                                                                                                     c1.course_name,                                                                                                                      g1.year,                                                                                                                             g1.sem,                                                                                                                              g1.total_score,s_name,score,rank() over(partition by student_name order by sem,score desc,s_name desc)                                       from student s1                                                                                                                        inner join courses c1 on c1.dp_id=s1.dept_id                                                                                               inner join grades g1 on s1.student_id=g1.stud_id                                                                                     inner join marks m1 on m1.stud_id=s1.student_id                                                               inner join subjects sub1 on sub1.subject_id=m1.subject_id                                                                            and g1.sem=sub1.sem_id)                                                                                                              select s1.student_id,s1.student_name,s1.course_name,                                                                                 s1.year,s1.sem,s1.total_score,max(case when s2.rank = 1 then s2.s_name end) as sub1,max(case when s2.rank = 1 then s2.score end) as score,max(case when s2.rank = 2 then s2.s_name end) as sub2,
max(case when s2.rank = 2 then s2.score end) as score,
max(case when s2.rank = 3 then s2.s_name end) as sub3,
max(case when s2.rank = 3 then s2.score end) as score from stud_details s1 left join stud_details s2 on s1.student_id=s2.student_id group by s1.student_id,s1.student_name,s1.course_name,s1.year,s1.sem,s1.total_score;





with stud_details as
        (
        select s1.student_id,                      
               s1.student_name,
               c1.course_name,
               g1.year,
               g1.sem,
               g1.total_score,
               s_name,score,rank() 
                over(partition by student_name,sem order by score desc,s_name desc) 
                        from student s1 
                                inner join courses c1 on c1.dp_id=s1.dept_id 
                                inner join grades g1 on s1.student_id=g1.stud_id 
                                inner join marks m1 on m1.stud_id=s1.student_id 
                                inner join subjects sub1 on sub1.subject_id=m1.subject_id and g1.sem=sub1.sem_id) 
                        select 
                                s1.student_id,
                                s1.student_name,
                                s1.course_name,
                                s1.year,
                                s1.sem,
                                s1.total_score,
                                max(case when s1.rank = 1 then s1.s_name end) as sub1,
                                max(case when s1.rank = 1 then s1.score end) as sub1,
                                max(case when s1.rank = 2 then s1.s_name end) as sub1,
                                max(case when s1.rank = 2 then s1.score end) as sub1,
                                max(case when s1.rank = 3 then s1.s_name end) as sub1,
                                max(case when s1.rank = 3 then s1.score end) as sub1
                               
        from stud_details s1                  
                group by s1.student_id,s1.student_name,s1.course_name,s1.year,s1.sem,s1.total_score order by student_id;
                
                
         










table(student_id int,
									student_name varchar,
									course_name varchar,
									year int,
									sem int,
									total_score int,
									sub1 varchar,
									score3 int,
									sub2 varchar,
									score1 int,
									sub3 varchar,
									score2 int) 



----start




       
             create or replace function p1(s_id int default null,score int default null) returns table(student_id int,
									student_name varchar,
									course_name varchar,
									year int,
									sem int,
									total_score int,
									sub1 text,
									score3 int,
									sub2 text,
									score1 int,
									sub3 text,
									score2 int) as
               


		 $_$
		declare
                        c boolean:= not null;
			v_sql text;
               
		begin
		      
			v_sql:='
                        	with stud_details as(
        			select s1.student_id,                      
			        s1.student_name,
			        c1.course_name,
			        g1.year,
			        g1.sem,
			        g1.total_score,
			        s_name,score,rank() 
				over(partition by s1.student_name,g1.sem order by score desc,s_name desc) 
                        	from student s1 
                                	inner join courses c1 on c1.dp_id=s1.dept_id 
                               		inner join grades g1 on s1.student_id=g1.stud_id 
                                	inner join marks m1 on m1.stud_id=s1.student_id 
                                	inner join subjects sub1 on sub1.subject_id=m1.subject_id and g1.sem=sub1.sem_id) 
                        		select 
                                		s1.student_id,
                                		s1.student_name,
                                		s1.course_name,
                                		s1.year,
                                		s1.sem,
                                		s1.total_score,
                                			max(case when s1.rank = 1 then s1.s_name end) as sub1,
                                			max(case when s1.rank = 1 then s1.score end) as score1,
                                			max(case when s1.rank = 2 then s1.s_name end) as sub2,
                                			max(case when s1.rank = 2 then s1.score end) as score2,
                                			max(case when s1.rank = 3 then s1.s_name end) as sub3,
                                			max(case when s1.rank = 3 then s1.score end) as score3
                               
        			from stud_details s1           
					where (case when $1 is not null then s1.student_id=$1 else true end) and 
					(case when $2 is not null then total_score > $2 else true end)    
	                		group by s1.student_id,s1.student_name,s1.course_name,s1.year,s1.sem,s1.total_score
					 order by student_id';
			
			return query execute v_sql using s_id,score;
	
		end;
		$_$
		LANGUAGE PLPGSQL;
















 create or replace function p1(s_id int default null,score int default null) returns table(student_id int,
									student_name varchar,
									course_name varchar,
									year int,
									sem int,
									total_score int,
									sub1 text,
									score1 int,
									sub2 text,
									score2 int,
									sub3 text,
									score3 int
									) as
               


		 $_$
		declare
                        c boolean:= not null;
			v_sql text;
               
		begin
		      
			v_sql:='
                        	select student_id,student_name,course_name,
                        	year,sem,total_score,sub1,score1,sub2,score2,sub3,score3 from(
                        	
                        	select *from(with stud_details as(
        			select s1.student_id,                      
			        s1.student_name,
			        c1.course_name,
			        g1.year,
			        g1.sem,
			        g1.total_score,
			        s_name,score,rank() 
				over(partition by s1.student_name,g1.sem order by score desc,s_name desc) 
                        	from student s1 
                                	inner join courses c1 on c1.dp_id=s1.dept_id 
                               		inner join grades g1 on s1.student_id=g1.stud_id 
                                	inner join marks m1 on m1.stud_id=s1.student_id 
                                	inner join subjects sub1 on sub1.subject_id=m1.subject_id and g1.sem=sub1.sem_id) 
                        		select 
                                		s1.student_id,
                                		s1.student_name,
                                		s1.course_name,
                                		s1.year,
                                		s1.sem,
                                		s1.total_score,
                                			max(case when s1.rank = 1 then s1.s_name end) as sub1,
                                			max(case when s1.rank = 1 then s1.score end) as score1,
                                			max(case when s1.rank = 2 then s1.s_name end) as sub2,
                                			max(case when s1.rank = 2 then s1.score end) as score2,
                                			max(case when s1.rank = 3 then s1.s_name end) as sub3,
                                			max(case when s1.rank = 3 then s1.score end) as score3,
                                			sum(total_score) over (partition by student_id) as total
                               
        			from stud_details s1           
					where (case when $1 is not null then s1.student_id=$1 else true end)
					  
	                		group by s1.student_id,s1.student_name,s1.course_name,s1.year,s1.sem,s1.total_score
					 order by student_id) t where (case when $2 is not null then total > $2 else true end)) t2';
			
			return query execute v_sql using s_id,score;
	
		end;
		$_$
		LANGUAGE PLPGSQL;
 





