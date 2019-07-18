Graph Database
==============
*A database with an explicit graph structure
*Each node knows its adjacent nodes.
*


Neo 4J
======

Neo4j is a graph database management system developed by Neo4j,
Inc. Described by its developers as an ACID-compliant transactional
database with native graph storage and processing,[4] 
Neo4j is the most popular graph database according to DB-Engines 
ranking.[5]

*A graph DB + lucene index
*support ACID property 
good for
--------
*social networks
*E commerce

Cypher Query Language − 
------------------------
Neo4j provides a powerful declarative query language known as Cypher.
It uses ASCII-art for depicting graphs. 
Cypher is easy to learn and can be used to create and retrieve relations 
between data without using the complex queries like Joins.

Built-in web application 
------------------------
Neo4j provides a built-in Neo4j Browser web 
application. Using this, you can create and query your graph data.

Indexing
---------
Neo4j supports Indexes by using Apache Lucence.

Neo4j Property Graph Data Model
===============================

Neo4j Graph Database follows the Property Graph Model to store and manage its data.

Following are the key features of Property Graph Model 

=>The model represents data in Nodes, Relationships and Properties

=>Properties are key-value pairs

=>Nodes are represented using circle and Relationships are represented using arrow keys

=>Relationships have directions: Unidirectional and Bidirectional

=>Each Relationship contains "Start Node" or "From Node" and "To Node" or "End Node"

=>Both Nodes and Relationships contain properties

=>Relationships connects nodes

In Property Graph Data Model, relationships should be directional. If we try to create relationships 
without direction, then it will throw an error message.

In Neo4j too, relationships should be directional. If we try to create relationships without direction, 
then Neo4j will throw an error message saying that "Relationships should be directional".

application
===========


Graph Fundamentals
==================
A graph database can store any kind of data using a few simple concepts:

*Nodes - graph data records
*Relationships - connect nodes
*Properties - named data values

*Nodes are the name for data records in a graph
*Data is stored as Properties
*Properties are simple name/value pairs

*A node can have zero or more labels
*Labels do not have any properties

*Similar nodes can have different properties
*Properties can be strings, numbers, or booleans
*Neo4j can store billions of nodes

Relationships always have direction
Relationships always have a type
Relationships form patterns of data

Neo4j uses Native GPE (Graph Processing Engine) to work with its Native graph storage format.

Neo4j Browser is a command driven client, like a web-based shell environment. It is perfect for running ad-hoc graph queries, with just enough ability to prototype a Neo4j-based application.

Developer focused, for writing and running graph queries with Cypher
Exportable tabular results of any query result
Graph visualization of query results containing nodes and relationships
Convenient exploration of Neo4j's REST API'

Single line editing for brief queries or commands
Switch to multi-line editing with <shift-enter>
Run a query with <ctrl-enter>
History is kept for easily retrieving previous commands

Special frames like data visualization
Expand a frame to full screen
Remove a specific frame from the stream
Clear the stream with the  :clear command





CREATE clause to create data
() parenthesis to indicate a node
ee:Person a variable 'ee' and label 'Person' for the new node
{} brackets to add properties to the node


Converting RDBMS to Graph DB
============================
Remove all foreign key replace with relationships

joins can be converted to relationships with properties 





Cypher Query Language
_____________________

Cypher is a declarative, SQL-inspired language for describing patterns in graphs visually using an ascii-art syntax.

It allows us to state what we want to select, insert, update or delete from our graph data without requiring us to describe exactly how to do it.


Nodes Genaral syntax
---------------------
MATCH (node:Label) RETURN node.property

MATCH (node1:Label1)-->(node2:Label2)
WHERE node1.propertyA = {value}
RETURN node2.propertyA, node2.propertyB


Relationships Genaral syntax
-----------------------------

MATCH (n1:Label1)-[rel:TYPE]->(n2:Label2)
WHERE rel.property > {value}
RETURN rel.property, type(rel)



match(c:college) <-[s:Belongs_TO]-(a)<-[k:is_a]-(x) return x.Department_name,k,a.name,s,c.name; 




TF-IDF
======

In information retrieval, tf–idf or TFIDF, short for term frequency–inverse document frequency, is a numerical statistic that is 
intended to reflect how important a word is to a document in a collection or corpus.[1] It is often used as a weighting factor in 
searches of information retrieval, text mining, and user modeling. The tf-idf value increases proportionally to the number of times
a word appears in the document, but is often offset by the frequency of the word in the corpus, which helps to adjust for the fact 
that some words appear more frequently in general. Nowadays, tf-idf is one of the most popular term-weighting schemes. For instance, 
83% of text-based recommender systems in the domain of digital libraries use tf-idf.[2]

inverse document frequency
==========================
Hence an inverse document frequency factor is incorporated which diminishes the weight of terms that occur very frequently in the document 
set and increases the weight of terms that occur rarely.

term frequency
==============