
			
			V1.0 aneeshk 04-sept-2017 : Function to display student details(input:student id,year)

			*/





create or replace function p1(s_id int default null,y int default null) returns table(student_id int,
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
									score3 int,
									total bigint
									) as
               


		 $_$
		declare
                        c boolean:= not null;
			v_sql text;
               
		begin
		      
			v_sql:='
                        	select student_id,student_name,course_name,
                        	year,sem,total_score,sub1,score1,sub2,score2,sub3,score3,total from(
                        	
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
					 order by student_id) t where (case when $2 is not null then t.year=$2 else true end)
		) t1';
			
			return query execute v_sql using s_id,y;
	
		end;
		$_$
		LANGUAGE PLPGSQL;
