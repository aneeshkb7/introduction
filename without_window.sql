select distinct m.emp_id mgr_id,
	m.name as mgr_name,
	mgr_emp.mgr_lat_emp_id from employee e 
		inner join employee m on 
			e.mgr_id = m.emp_id inner join 
			(
			select distinct on (mgr_id) mgr_id,
					emp_id as mgr_lat_emp_id 
						from employee
		                    where mgr_id is NOT NULL     
		                    order by mgr_id,joining_date desc    
		     )mgr_emp on m.emp_id = mgr_emp.mgr_id