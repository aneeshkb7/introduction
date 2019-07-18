/* from psql prompt */

\timing -- to show the execution time of a query after execution or to hide execution time(by default off).

\d -- to list tables in the database. 

\d table_name -- to describe table.

\d+ -- to list all the tables in the database along with some additional information.

\d+ table_name --describe table with additional information

\dv -- list all the views

\dt -- list tables only

\ds -- list all the sequences
\l --list all the databases.

\l+ --list all databases with additional information. 

\dn --list all schemas.

\dn+ --list all schemas with additional information.

\df -- list all functions.

\df+ --list all function with additional info.

\c -- connect to another database.

\q -- to quit from postgres shell.

\e --text editor inside psql.

\h -- to get help with psql querys. 

\e --to open an editor

\i \path file.sql --to run external file

\a -- to allign or un align output format

/*from terminal*/

psql -l -- to list all the databases.

psql -d dbname -- to connect to a database.

pg_dump -W -U username -h hostname database_name > file.sql -- to backup database into a file.

psql -W -U username -H hostname < file.sql -- load data into sql

psql -H -c "command" -- display data in html format

psql -L abc.txt -- stores the out put of the querys to abc.txt;

psql -q --Specifies that psql should do its work quietly. By default, it prints welcome messages and various informational output. If this option is used, none of this happens. This is useful with the -c option. This is equivalent to setting the variable QUIET to on.

psql -s -- User is prompted before each command is sent to the server
psql -S -- single line commnd. no need of semi colon 
psql -t or /t -- only show data now field names will be displayed
\c database_name username hostname -- to connect to another database.
\C title -- to set title for a table
\g -- print the output of last executed query
\s filename -- store the code history to the file
\dp -- display privilages of tables,views,..

\watch <time in seconds> -- will display the output of last executed query after every t second 


