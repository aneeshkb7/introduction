/*To list the current connected databse name it contain only one column and one row */
select *from information_schema_catalog_name;

/*
  To identify character set available in the current database
*/
select *from character_sets; --here we can find the charecter set name and name of the database

/*To view the details of functions used by check constraints*/
select *from check_constraint_routine_usage;

/*to view details of all check constraint in the current database */
select *from check_constraints;

/*to vew all the options defined for foreign table column */
select *from column_options; -- from this table we can get the table name and column name(Note: only foreign table column)
			     -- from this we can obtain information about
						--table_catalog //database in which the foreign table belongs to.
						--table_name //name of the foreign table.
						--column_name //name of the column.
						--option_name //name of the option.
						--option_value //name of the option value.
 

/*to view all the details about columns in the current database */
select *from columns; 	-- Only those columns are shown that the current user has access to.
			-- we can use this query to know details about a specific column in a table 
			-- from this table we can obtain information about.
					--column_name //name of the column.
					--datat_ype   //data type of the column.
					--is_nullable //weather it can be null or not.
					--table_name  // the table name in which the column belongs to.
					--table_catalog //the database name in which the table belongs to.
					--is_updatable  //weather the column can be updated or not. 
		

/*to view details of constraints used in a column of a table */
select *from constraint_column_usage; -- we can use this function to display constraints used in a  specific column,
				      -- from this table we can obtain information about.
						--table_catalog //database name in which the table belongs to.
						--table_name //name of the table in which the column belongs to.
						--column_name  //name of the column in which the constraint belongs to.
						--constraint_catalog//database where the constraint belongs to.
						--constraint_name //name of the constraint.

				      
/*to view details of constraints used in a table */
select *from constraint_table_usage; -- we can use this function to display constraints used in a  specific table,
				     -- it excludes details of check constraint.
				     -- from this table we can obtain information about.
						--table_catalog //database name in which the table belongs to.
						--table_name //name of the table in which the constraint belongs to.
						--constraint_catalog //database where the constraint belongs to.
						--constraint_name //name of the constraint.
				
/* to view details of foreign key and primary key in the current database */
select *from key_column_usage; -- we can use this function to know about the foreign keys and primary keys in a specific table
			       -- it contain fields table_name,table_schema,column_name,constraint_name,etc .. 
			       -- from this table we can obtain information about.
						--table_catalog //database name in which the table belongs to.
						--table_name //name of the table in which the constraint belongs to.
						--constraint_catalog //database where the constraint belongs to.
						--constraint_name //name of the constraint.
						--column_name // name of the column in which the constraint belongs to


/* to view the details of the parameters of a function */
select *from parameters; -- it can be used to display parameters in a specific catalog and schema.
			 -- it contain fields specific_schema,specific_catalog,specfic_name,parameter_mode,etc..
			 -- from this table we can obtain information about.
			 		--specific_catalog //name of the db function belongs to.
					--specific_name //unique name of the function.
					--parameter_mode //[IN/OUT/INOUT].
					--parameter_name //name of the parameter.
					--data_type // datatype of the parameter.


/* to view the details of the foreign keys in the current data base */
select *from referential_constraints; -- we can use this this table to view foreign keys in a specific database
				      -- from this table we can obtain information about.
							--constraint_catalog //name of the database in which the constraint belongs to.
							--constraint_name //name of the constraint.
							--unique_constraint_name // name of the primary key that the foreign key 							--referencing.
							--unique_constraint_catalog // name of the database where the primary key belongs 							--to.


/* to view the details of the privilages granted on a column like insert,update,references,select */
 select *from role_column_grants; 
					  --from this table we can obtain information about.
							--grantor //name of the role that granted the privilage.
							--grantee //name of the role that the privilage is granted to.
							--table_catalog //name of the database that the table belongs to.
							--table_name //name of the table that the column belongs to.
							--privilage_type //[SELECT/INSERT/UPDATE/REFERENCE].
							--is_grantable //YES if the privilege is grantable, NO if not


/* to view the details of the privilages granted on a function */
select *from role_routine_grants; -- here we can find weather a function has execution privilage or not
				 		--from this	table we can obtain information about.
				 				--grantor //name of the role that granted the privilage.
								--grantee //name of the role that the privilage is granted to.
								--specific_catalog //name of the db in which function belongs to.
								--specific_name //unique name of the function.
								--privilage_type //always execute
								--is_grantable //YES if the privilege is grantable, NO if not


/* to view the details of the privilages granted on a table */
select *from role_table_grants; -- we can use this table to display details about what are the operations we can perform on a table
						--from this	table we can obtain information about.
								--privilage_type //Type of the privilege such as SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, or TRIGGER.
								--grantor //name of the role that granted the privilage.
								--grantee //name of the role that the privilage is granted to.
								--table_catalog //name of the database that the table belongs to.
								--table_name //name of the table.
								--is_grantable //YES if the privilege is grantable, NO if not

/* to view all the detail about routines in the current database */
select *from routines; -- here we can access the routine definition using routine_definition attribute
		        --from this	table we can obtain information about.
			       		--specific_catalog //name of the db function belongs to.
						--specific_name //unique name of the function.
						--routine_name //name of the function.
						--routine_type //always function.
						--routine_definition //this atribute can be used to return the definition of the routine.


/*to view details about all the schemas in the current database */
select *from schemata; -- we can use this table to find a specific schema owned by a specific user
		       --from this	table we can obtain information about.
		       		--catalog_name //database name where the schema is located.
		       		--schema_name // name of the schema
			

/* to view details about various size limit and maximum values in postgresql 
like maximum length of database name,schema name,table name so on.,*/
select *from sql_sizing;
			--sizing_name //Descriptive name of the sizing item
			

/* to view details of all constraints belonging to a table */
select *from table_constraints; 
				--constraint_catalog //name of the database in which the constraint belongs to.
				--constraint_name //name of the constraint.
				--table_catalog //name of database in which the constraint belongs to.
				--table_name //name of the table
				--constraint_type[CHECK, FOREIGN KEY, PRIMARY KEY, or UNIQUE] //


/* to view details of all privilages granted on a table */
select *from table_privileges; -- we can identify what are the operations supported in a table such as truncate,delete,updation,insert,etc..
			      	--privilage_type //Type of the privilege: SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, or TRIGGER.
					--grantor //name of the role that granted the privilage.
					--grantee //name of the role that the privilage is granted to.
					--table_catalog //name of the database that the table belongs to.
					--table_name //name of the table.
					--is_grantable //YES if the privilege is grantable, NO if not

/*to view tables in the current data base */
select *from tables; -- it contain fields table_type,table_name,table_schema,table_catalog,etc ..
				--table_catalog // name of the database the table belongs to.
				--table_name // name of the table.
				--table_type // Type of the table: BASE TABLE for a persistent base table (the normal table type), VIEW for a view, FOREIGN TABLE for a foreign table, or LOCAL TEMPORARY for a temporary table

/* to view details of the triggers in the current database */
select *from triggers; -- the table contain fields trigger_schema,trigger_catalog,trigger_name,action_timing,event_manipulation,
		       -- event_object_catalog,event_object_table,etc ...
		       --trigger_catalog //data base in which the trigger belongs to.
		       --trigger_name // name of the trigger.
		       --event_manipulation //which event the trigger using INSERT, UPDATE, or DELETE
		       --event_object_catalog // the database name of the table that trigger event uses
		       --event_object_table // Name of the table that the trigger event uses.
		       --action_statement //EXECUTE PROCEDURE function_name(..)
		       --action_timing // BEFORE, AFTER, or INSTEAD OF

 
/* to view details of views in the current database */
select *from views;
		-- we can access the code used for the creation of a particular view table using view_definition atribute.
		-- it contain fields table catalog,table schema,table_name,is_updatable,is_insertable_into,etc...
				--table_catalog // name of the catalog the view belongs to.
				--table_name // name of the view;
				--view_definition // the source code of view table


/* 
   System catalogs
   ===============

/*to view information about all authorization identifiers */
select *from pg_authid;
			-- here we can identify weather a user is super user or not  and what are the roles assigned to that 				-- particular user.
			--rolname // name of the role
			--rolsuper //weather the role has super user privilage if yes t else f.


/*to view details about the primary key,foreign key constraints in the current database */
select *from pg_constraint;
			-- it contain fields conname,conrelid,etc conrelid can be used to find in which table the constraint 
			-- belongs to using(pg_class.oid).
			--conname // name of the constraint
			--conrelid //id of the table the constraint belongs to

/* to view details about all the available database */
select *from pg_database;
		--datname //name of the database

/* to display the details about the languages that can be used to write stored procedure */
select *from pg_language;
	--lanname // name of the language
/* to view information about the operators in psql */
select *from pg_operator;
			-- it contain fields oprname,oprcode etc
			--oprname //name of the operator
			--oprcode //operator code

/*to view details about functions available in psql */
select *from pg_proc;
			-- it contain fields proname,prosrc,etc the prosrc can be used to view the function definition;
			-- proname //name of the function.
			-- prosrc //we can use this atribute to view the source code of the function.
/* to view details about triggers in the current database */
select *from pg_trigger;
			-- it contain fields tgname,tgrelid,etc.. the tgrelid field can be used to identify which table the 
			-- trigger belongs to using pg_class.oid;
			--tgname //trigger name
			--tgrelid //id of the table in which the trigger belongs to

/* to view information about available datatypes in psql*/
select *from pg_type;
		--typname //data type name.

/* 
	System views
	============
*/

/* to display details about available cursors */
select *from pg_cursors;
		--name //name of the cursor.
/* to view information about each table in the database */
select *from pg_tables;
			-- it contain fields schemaname,tablename,tableowner,hastriggers etc
			-- hastrigger can be used to identify any trigger is defind for the particular table;
			-- tablename //name of the table
			-- tableowner //owner of the table.
			-- hastrigger //weather the table has any trigger if yes t else f
/* to view information about database users */
select *from pg_user;

/* to view information about views */
select *from pg_views;
		-- it contains fields schemaname,viewname,definition, the definition atribute can be used to view the source code 			-- of the view. 
		--viewname //name of the view
		--definition //definition of view






 
















