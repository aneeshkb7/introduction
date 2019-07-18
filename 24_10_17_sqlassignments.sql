-- Query to display empname and manager name including ceo's
  select e.name as emp_name,
    m.name as manager_name from 
    employee e left join employee m on 
      e.mgr_id=m.emp_id;
      
      
      
 -- Query to display Latest joined employee using window function
 
 select t.manager_name,
  t.name as emp_name,
  t.joining_date from(
    select m.name as manager_name,
    e.name,e.joining_date,
    rank() over 
      (partition by m.name order by e.joining_date desc)         
        from employee e          
        inner join employee m on
          e.mgr_id=m.emp_id              
            group by m.name,e.name,e.joining_date
              ) t where rank=1;
              
   
   
   -- Query to display Latest joined employee using without window function
 
 
 select distinct m.emp_id mgr_id,
	m.name as mgr_name,k.name as emp_name,
	mgr_emp.mgr_lat_emp_id from employee e 
		inner join employee m on 
			e.mgr_id = m.emp_id inner join 
			(
			select distinct on (mgr_id) mgr_id,
					emp_id as mgr_lat_emp_id 
						from employee
		                    where mgr_id is NOT NULL     
		                    order by mgr_id,joining_date desc    
		     )mgr_emp on m.emp_id = mgr_emp.mgr_id inner join employee k on mgr_lat_emp_id=k.emp_id;
         
         
         -- Query to display emp_id,emp_name,mgr_name,Dept’s_first_emp,Mgr’s_emp_count

        select e.emp_id,e.dept_id,
            e.name as employee,
            e.joining_date,
            m.name as manager,
            first_value(e.name) over(partition by e.dept_id order by e.joining_date) as first_person,
            count(m.emp_id) over (partition by m.emp_id)
            from employee e left join
            employee m on e.mgr_id=m.emp_id order by e.emp_id; 
	    
	    
	    
	    
	    
	    -- Query to display the employee table as single row
	    
select 
	'(' 
		|| emp_id ||
	',' 
  	|| '''' 
	|| name || 
	'''' || ','   
  || (case when dept_id is not NULL then dept_id::text else 'NULL' end) || 
  ',' 
  || (case when  mgr_id is not NULL then mgr_id::text else 'NULL'  end) || 
  ',' 
  || salary ||
  ',' || '''' 
  ||  joining_date || 
  '''' || ',' 
  || (case when termination_date is not null then '''' 
  || termination_date::text ||
  '''' else 'NULL' end) || ')' 
  from employee
  

