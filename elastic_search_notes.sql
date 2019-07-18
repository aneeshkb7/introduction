Elasticsearch is a search engine based on Lucene. It provides a distributed, multitenant-capable full-text search engine 
with an HTTP web interface and schema-free JSON documents. Elasticsearch is developed in Java and is released as open source 
under the terms of the Apache License. Official clients are available in Java, .NET (C#), PHP, Python, Apache Groovy and many 
other languages.[2] Elasticsearch is the most popular enterprise search engine followed by Apache Solr, also based on Lucene.

Elasticsearch is developed alongside a data-collection and log-parsing engine called Logstash, and an analytics and visualisation 
platform called Kibana. The three products are designed for use as an integrated solution, referred to as the "Elastic Stack" 
(formerly the "ELK stack").

KIBANA is an open source data visualization plugin for Elasticsearch. It provides visualization capabilities on top of the content 
indexed on an Elasticsearch cluster. Users can create bar, line and scatter plots, or pie charts and maps on top of large volumes of 
data.

Logstash provides an input stream to Elastic for storage and search

Elasticsearch can be used to search all kinds of documents. It provides scalable search, has near real-time search, and supports 
multitenancy

software multitenancy refers to a software architecture in which a single instance of software runs on a server and serves multiple 
tenants. A tenant is a group of users who share a common access with specific privileges to the software instance

Elasticsearch is distributed, which means that indices can be divided into shards and each shard can have zero or more replicas.

Each node hosts one or more shards, and acts as a coordinator to delegate operations to the correct shard(s). Rebalancing and routing 
are done automatically.

Related data is often stored in the same index, which consists of one or more primary shards, and zero or more replica shards. Once 
an index has been created, the number of primary shards cannot be changed.

Horizontal scaling
------------------
Horizontal scaling means that you scale by adding more machines into your pool of resources whereas Vertical scaling means that you 
scale by adding more power (CPU, RAM) to an existing machine.

distributed transaction
-----------------------
A distributed transaction is a database transaction in which two or more network hosts are involved. Usually, hosts provide transactional
resources, while the transaction manager is responsible for creating and managing a global transaction that encompasses all operations 
against such resources. Distributed transactions, as any other transactions, must have all four ACID (atomicity, consistency, isolation,
durability) properties, where atomicity guarantees all-or-nothing outcomes for the unit of work (operations bundle).