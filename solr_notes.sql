In the case of large data analysis rdbms lags in perfomance
--we need to write complex querys to get the relavant result.

Lucene
======
Lucene is a full-text search library developed in Java by Doug Cutting which makes it easy to add search
functionality to an application or a website.

How Lucene Works?

Lucene works based on inverted index. This means that it takes all the documents, splits them into words,
and then builds an index for each word with the list of document ids where it is referred.

Apache solr
===========

Solr is a full-text search server developed by Yonik Seeley based on Lucene, this is the widely used 
search solution on the planet which is both established & growing


Search Engine 
=============
A Search Engine refers to a huge database of Internet resources such as webpages,
newsgroups, programs, images, etc. It helps to locate information on the World Wide Web.
Users can search for information by passing queries into the Search Engine in the form of
keywords or phrases. The Search Engine then searches in its database and returns
relevant links to the user.

components
----------
=>Web Crawler
=>Database
=>Search Interfaces


solr
====

to create nodes
----------------
bin/solr start -e cloud

to start solr
-------------
bin/solr -e cloud -noprompt

Nodes and cores
---------------

In SolrCloud, a node is Java Virtual Machine instance running Solr, commonly called a server. Each Solr core 
can also be considered a node. Any node can contain both an instance of Solr and various kinds of data.


to delete all data
--------------------
http://localhos:port/solr/corename/update?commit=true&stream.body=<delete><query>*:*</query></delete>



to post data 
------------
bin/post -c collection_name example/films/films.json


Faceting
--------
One of Solr’s most popular features is faceting. Faceting allows the search results to be arranged into subsets (or buckets, or categories), providing a count for each subset. There are several types of faceting: field values, numeric and date ranges, pivots (decision tree), and arbitrary query faceting.

 curl "http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.field=genre_str"

setting range
-------------
curl 'http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.range=initial_release_date&facet.range.start=NOW-20YEAR&facet.range.end=NOW&facet.range.gap=%2B1YEAR';

Pivot Facets
------------
Another faceting type is pivot facets, also known as "decision trees", allowing two or more fields to be nested for all the various possible combinations. Using the films data, pivot facets can be used to see how many of the films in the "Drama" category (the genre_str field) are directed by a director. Here’s how to get at the raw data for this scenario:

curl "http://localhost:8983/solr/films/select q=*:*&rows=0&facet=on&facet.pivot=directed_by_str,genre_str"

Indexing Ideas
--------------

Local Files with bin/post
------------------------
bin/post -c localDocs ~/Documents

For converting the result of a postgres query to xml

SELECT query_to_xml('SELECT * FROM student', true, false, '');

for converting a postgres table to xml

SELECT table_to_xml('table_name', true, false, '');

to delete
========
 curl http://localhost:8983/solr/employee/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'
 curl http://localhost:8983/solr/employee/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
 
 to push the changes of schema file to solr server
bin/solr zk upconfig -n employee -d server/solr/configsets/employee/ -zkhost localhost:9983





