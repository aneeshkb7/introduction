--program to display latest joined employee under a manager 

select t.manager_name,
  t.name as emp_name,
  t.joining_date from
    (select m.name as manager_name,
    e.name,e.joining_date,
    rank() over (partition by m.name order by e.joining_date desc)         
      from employee e
        inner join employee m on
          e.mgr_id=m.emp_id              
            group by m.name,e.name,e.joining_date) t where rank=1;
