DOS vs. Unix Line Endings
=========================

Text files created on DOS/Windows machines have different line endings than files created 
on Unix/Linux. DOS uses carriage return and line feed ("\r\n") as a line ending, which Unix uses just line feed ("\n").
You need to be careful about transferring files between Windows machines and Unix machines to make sure the line endings are translated properly.


postgres_fdw
============
The postgres_fdw module provides the foreign-data wrapper postgres_fdw, which can be used to access data stored in external PostgreSQL servers.

To prepare for remote access using postgres_fdw:
------------------------------------------------
=>create extension
=>create server
=>create user mapping
=>create foreign table

libpq
======
libpq is the C application programmer's interface to PostgreSQL. libpq is a set of library functions that allow client programs to pass queries to 
the PostgreSQL backend server and to receive the results of these queries.
'
The default behavior of PQerrorMessage() is now to print CONTEXT only for errors.
The new function PQsetErrorContextVisibility() can be used to adjust this.

typedef enum
{
    PQSHOW_CONTEXT_NEVER,
    PQSHOW_CONTEXT_ERRORS,
    PQSHOW_CONTEXT_ALWAYS
} PGContextVisibility;

The NEVER mode never includes CONTEXT, while ALWAYS always includes it if available.
In ERRORS mode (the default), CONTEXT fields are included only for error messages,


ERROR:  value too long for type character varying(32)
CONTEXT:  SQL statement "update pref_users set first_name =  $1 ,
last_name =  $2 , female =  $3 , avatar =  $4 , city =  $5 , last_ip =
 $6 , login = now() where id =  $7 "
        PL/pgSQL function "pref_update_users" line 3 at SQL statement

and (same error, but different line number)



fPIC
====
The -fPIC choice always works, but may produce larger code than -fpic (mnenomic to remember this is that PIC is in a 
larger case, so it may produce larger amounts of code). Using -fpic option usually generates smaller and faster code,
but will have platform-dependent limitations, such as the number of globally visible symbols or the size of the code.

Shared Library
--------------
A shared library is a file containing object code that several a.out files may use simultaneously while executing. ... 
Instead, a special section called .lib that identifies the library code is created in the object file.

Code must be ‘position-independent’
-----------------------------------
Can’t jump or call to fixed addresses
Can’t access data at fixed locations
No direct use of labels



pg_dump & restore
-----------------
pg_dump -Fc postgres > abc.sql
pg_restore -l abc.sql


Replace newlines by spaces, which is sufficient to make the output valid for pg_restore -L's purposes.


CREATEUSER NOCREATEUSER
------------------------
These clauses determine whether a user will be permitted to create new users himself. 
CREATEUSER will also make the user a superuser, who can override all access restrictions. If not specified, NOCREATEUSER is the default.

postgresql.conf //you can change auto vaccuam settings

vaccuam full //we need to stop every operations on table
vaccuam standard // you may not able to change the definition of table.
