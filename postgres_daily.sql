explain
=======
This command displays the execution plan that the PostgreSQL planner generates for the supplied statement. The execution plan shows 
how the table(s) referenced by the statement will be scanned — by plain sequential scan, index scan, etc. — and if multiple tables 
are referenced, what join algorithms will be used to bring together the required rows from each input table.

ANALYZE
-------
Carry out the command and show actual run times and other statistics. This parameter defaults to FALSE.

VERBOSE
-------
Display additional information regarding the plan. Specifically, include the output column list for each node in the plan tree, 
schema-qualify table and function names, always label variables in expressions with their range table alias, and always print 
the name of each trigger for which statistics are displayed. This parameter defaults to FALSE.

COSTS
-----
Include information on the estimated startup and total cost of each plan node, as well as the estimated number of rows and the 
estimated width of each row. This parameter defaults to TRUE.

BUFFERS
--------
Include information on buffer usage. Specifically, include the number of shared blocks hit, read, dirtied, and written, the number 
of local blocks hit, read, dirtied, and written, and the number of temp blocks read and written. A hit means that a read was avoided 
because the block was found already in cache when needed. Shared blocks contain data from regular tables and indexes; local blocks 
contain data from temporary tables and indexes; while temp blocks contain short-term working data used in sorts, hashes, Materialize 
plan nodes, and similar cases. The number of blocks dirtied indicates the number of previously unmodified blocks that were changed by 
this query; while the number of blocks written indicates the number of previously-dirtied blocks evicted from cache by this backend 
during query processing. The number of blocks shown for an upper-level node includes those used by all its child nodes. In text format, 
only non-zero values are printed. This parameter may only be used when ANALYZE is also enabled. It defaults to FALSE.

TIMING
------
Include actual startup time and time spent in each node in the output. The overhead of repeatedly reading the system clock can slow down 
he query significantly on some systems, so it may be useful to set this parameter to FALSE when only actual row counts, and not exact 
times, are needed. Run time of the entire statement is always measured, even when node-level timing is turned off with this option. 
This parameter may only be used when ANALYZE is also enabled. It defaults to TRUE.

FORMAT
------
Specify the output format, which can be TEXT, XML, JSON, or YAML. Non-text output contains the same information as the text output format, 
but is easier for programs to parse. This parameter defaults to TEXT.