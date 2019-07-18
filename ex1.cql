create(Manu:Employee{Emp_ID:1,name:"Manu",age:"21",dept_id:20}),
(Vimal:Employee{Emp_ID:2,name:"Vimal",age:"21",dept_id:21}),
(Anoop:Employee{Emp_ID:3,name:"Anoop",age:"23",dept_id:20}),
(Gokul:Employee{Emp_ID:4,name:"Gokul",age:"21",dept_id:20}),
(Ganesh:Employee{Emp_ID:5,name:"Ganesh",age:"21",dept_id:21}),
(Vijay:Employee{Emp_ID:6,name:"Vijay",age:"21",dept_id:22}),
(Jan:Employee{Emp_ID:7,name:"Jan",age:"21",dept_id:20}),
(Murali:Employee{Emp_ID:8,name:"Murali",age:"21",dept_id:20}),
(Ashok:Employee{Emp_ID:9,name:"ashok",age:"21",dept_id:22}),
(david:Employee{Emp_ID:10,name:"David",age:"21",dept_id:21})



create(IT:Department{Department_name:"IT",id:20}),
(CSE:Department{Department_name:"CSE",id:21}),
(EEE:Department{Department_name:"EEE",id:22}),
(ECE:Department{Department_name:"ECE",id:23})

match(e:Employee)
match(d:Department{id:dept_id})
(e)-[:Belongsto]->(d);

match(c:college)
match(d:Department)
merge(d)-[:Belongsto]->(c)

create(GEC:college{name:"GEC SKP",reg_id:1010})
create(d:Department)
create(GEC:college{name:"GEC SKP",reg_id:1010})

MATCH(n:Employee) SET n.email = "default@abc.com";

//to delete relationships
match(n:Employee) -[r:Belongsto]->()
detach delete r;


HOME
ACADEMICS
ADMINISTRATION
DEPARTMENTS
TEQIP
FACILITIES
ACTIVITIES
RESEARCH


create (a:Academics),(b:Administration),(c:Departments),(d:Facilities)(e:Activities);

 match(a:Department)
 match(b:Departments)
 merge
 (a)-[:is_a]->(b);


match(a:Administration)
match(b:Departments)
match(c:Facilities)
match(d:Academics)
match(e:Activities)
match(f:college)
merge
(a)-[:Belongs_TO]->(f),
(b)-[:Belongs_TO]->(f),
(c)-[:Belongs_TO]->(f),
(d)-[:Belongs_TO]->(f),
(e)-[:Belongs_TO]->(f);