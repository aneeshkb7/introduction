PostgreSQL
==========
PostgreSQL is a general purpose and object-relational database management system, 
the most advanced open source database system. PostgreSQL was developed based on
POSTGRES 4.2 at Berkeley Computer Science department, University of California.

PostgreSQL is a general-purpose object-relational database management system. 
It allows you to add custom functions developed using different programming 
languages such as C/C++, Java, etc.

PostgreSQL is designed to be extensible. In PostgreSQL, you can define your 
own data types, index types, functional languages, etc. If you don’t like any 
part of the system, you can always develop a custom plugin to enhance it to 
meet your requirements e.g., adding a new optimizer.

Installation
=============

sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

postgres select
===============

select is used to query data from a table.

*clauses that can be used with select
------------------------------------

==> distinct --to select distinct rows.
	--------
	The DISTINCT clause is used in the SELECT statement to remove duplicate rows from 
	the result set. The DISTINCT clause keeps one row for each group of duplicates. The DISTINCT clause  can be used on one or more columns of a table.


	If you specify multiple columns, the DISTINCT clause will evaluate the duplicate based on the combination of values of these columns.

	distinct on
	-----------
	select distinct on (film_id) film_id,inventory_id from inventory order by 1 limit 5;
	distict on :- prints the first row of each group of	duplicates.

==> where
	-----
	where clause conditions are used to filter data returned by select statement.


	Operator	Description
	--------	-----------
	=			Equal
	>			Greater than
	<			Less than
	>=			Greater than or equal
	<=			Less than or equal
	<> or !=	Not equal
	AND			Logical operator AND
	OR			Logical operator OR

==>	like
	-----

	used for pattern matching
	-------------------------

	Percent ( %)  for matching any sequence of characters.
	Underscore ( _)  for matching any single character.

	eg:
	SELECT first_name,last_name
		FROM
		 customer
		WHERE
		 first_name LIKE '%er%'

	ILIKE
	-----
	matches values case insensitively


	~~ is equivalent to LIKE
	~~* is equivalent to ILIKE
	!~~ is equivalent to NOT LIKE
	!~~* is equivalent to NOT ILIKE

	eg :
	select first_name from customer where first_name ~~* 'rac%';

==>	IN
	-----
	we use the IN operator in the WHERE clause to check if a value matches any value in a list of values. 

	SELECT first_name, last_name
	FROM
	 customer
	WHERE
 		customer_id IN (
 			SELECT
 				customer_id
 			FROM
 			rental
 			WHERE
 				CAST (return_date AS DATE) = '2005-05-27' --CAST is used for type casting, return_date data type is time_stamp
			 );


 	NOT IN
 	------
 	We can combine the IN operator with the NOT operator to select rows whose values do not match the values in the list.

 	eg:

 	SELECT
 		customer_id,
 		rental_id,
 		return_date
		FROM
		 rental
		WHERE
		 customer_id NOT IN (1, 2);



==>	BETWEEN
	-------
	We use the BETWEEN operator to match a value against a range of values.

	Eg:

		SELECT
	 		customer_id,
			payment_id,
			amount
		FROM
			payment
		WHERE
			amount BETWEEN 8 AND 9;



	NOT BETWEEN
	-----------
	to match values that is not belongs to a range of values;

	Note: Both BETWEEN and NOT BETWEEN include the range values.


==> ORDER BY
	--------

	allow us to sort rows returned by select statementin  ascending or descending order

	if  we use multiple columns in order by then it check the 2nd column only if the first column have the same value.

	eg:
	SELECT
		column_1,
		column_2
	FROM
		tbl_name
	ORDER BY
		column_1 ASC,
		column_2 DESC;

==> LIMIT
	-----

	Returns a subset of rows returned by select statement

	limit n returns n rows;
	limit 5 returns 5 rows;


	OFFSET -- skips first m rows
	------

	if we give OFFSET with limit statement it skips the first m rows then displays n rows;
	ie

	offset 5 limit 3 -- skips first 5 rows and print the next 3 rows;
	Note:limit null print every row
	eg:

		SELECT	*
			FROM
			 table
			LIMIT n OFFSET m;


	Note:offset and limit alone works;





==>	GROUP BY

The GROUP BY clause divides the rows returned from the SELECT statement into groups. 
For each group, you can apply an aggregate function e.g., SUM to calculate the sum of items 
or COUNT to get the number of items in the groups.

eg:
SELECT
	customer_id,
	SUM (amount)
	FROM
		payment
		GROUP BY
			customer_id
			ORDER BY
				SUM (amount) DESC;


==> HAVING
	We often use the HAVINGclause in conjunction with the GROUP BY clause to filter group rows that do not satisfy a specified condition.


	The HAVINGclause sets the condition for group rows created by the GROUP BY clause after the GROUP BY
	clause applies while the WHERE clause sets the condition for individual rows before GROUP BY clause applies.
	This is the main difference between the HAVINGand WHEREclauses.

	SELECT
		customer_id,
		SUM (amount)
		FROM
			payment
			GROUP BY
				customer_id
				HAVING
					SUM (amount) > 200;


==> UNION 

The UNION operator combines result sets of two or more SELECT statements into a single result set. 

	*-> Both queries must return the same number of columns.
	*-> The corresponding columns in the queries must have compatible data types.

The UNION operator removes all duplicate rows unless the UNION ALL is used.

eg:

	select student_id from student union select stud_id from marks;



==>INTERSECT

INTERSECT operator combines the result sets of two or more SELECT statements into a single result set.
The INTERSECT operator returns all rows in the both result sets.

->The number of columns and their order in the SELECT clauses must the be the same.
->The data types of the columns must be compatible
eg:
select student_id from student intersect select stud_id from marks;




==>EXCEPT

EXCEPT operator returns rows by comparing the result sets of two or more quires.
The EXCEPT operator returns distinct rows from the first (left) query that are not in the output of the second (right) query. The following illustrates the syntax of the EXCEPT operator.
eg:
to print details of the employees who are not managers.
---	--		--			---	-			---	-----------
select e.name,e.emp_id from employee e 
left join employee m on e.emp_id=m.mgr_id except
(select e.name,e.emp_id from employee e 
left join employee m on e.emp_id=m.mgr_id
 where m.mgr_id is not null) order by emp_id;


==> INNER JOIN

If we want to select rows from the A table that have corresponding rows in the B table, we use the INNER JOIN clause.

*First, you specify the column in both tables from which you want to select data in the SELECT clause
*Second, you specify the main table i.e.,  A in the FROM clause.
*Third, you specify the table that the main table joins to i.e., B in the INNER JOIN clause. In addition, you put a join condition after the ON keyword


For each row in the A table, PostgreSQL scans the B table to check if there is any row that matches the condition .
 If it finds a match, it combines columns of both rows into one row and add the combined row to the returned result set.
eg:

	SELECT
		customer.customer_id,
		first_name,
		last_name,
		email,
		amount,
		payment_date
		FROM
			customer
			INNER JOIN 
				payment ON payment.customer_id = customer.customer_id;

==> FULL JOIN

The full outer join combines the results of both left  join and right join.
If the rows in the joined table do not match, the full outer join sets NULL values for every column of the table that 
lacks a matching row. For the matching rows , a single row is included in the result set that contains columns populated
from both joined tables.

 select student_id,
 	student_name,
 	department_name 
 		from student 
 			full join department 
 				on dept_id=department_id;


==> LEFT JOIN

The LEFT JOIN clause returns all rows in the left table ( A) that are combined with rows in the right table ( B) even though there is no corresponding rows in the right table ( B).

==> NATURAL JOIN

By default natural join acts like inner join if there are matching columns in both table else it acts like cross join.



	








