/* Installation

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

update-java-alternatives --list
sudo update-java-alternatives --jre --set /usr/lib/jvm/java-8-oracle

wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee -a /etc/apt/sources.list.d/neo4j.list
sudo apt-get update

sudo apt-get install neo4j=1:3.4.7

comment bwlow line in /etc/neo4j/neo4j.conf
#dbms.directories.import=/var/lib/neo4j/import
uncomment below line in the above conf file
dbms.security.allow_csv_import_from_file_urls=true
also set the bolt listen address to the host ip address


--change password using cypher shell
cypher-shell
CALL dbms.changePassword('admin@neo4j');

add below lines in /etc/neo4j/neo4j.conf 

##### To have HTTP accept non-local connections, uncomment this line
dbms.connector.http.address=0.0.0.0:7474

dbms.connectors.default_listen_address=0.0.0.0

org.neo4j.server.webserver.address=0.0.0.0

sudo service neo4j restart

*/


-----------------------------------------------------------------------------------------------------------

\copy (select id as subcluster_id, id||':SubCluster' as subcluster_name,unnest(key_words) as vocab from metrics_stage.kmeans_abstract_top_30terms_v13) to /tmp/cluster_vocabs_mapping.csv with csv header
 
LOAD CSV WITH HEADERS FROM "file:///tmp/cluster_vocabs_mapping.csv" AS csvLine
MERGE (subcluster:Sub_Clusters { name: csvLine.subcluster_name, id: toInteger(csvLine.subcluster_id) })
MERGE (vocab:Vocabs { name: csvLine.vocab })
CREATE (subcluster)-[:contains]->(vocab)
 
\copy (select subcluster_id, patent_id, patnum from (select subcluster_id, unnest(patent_ids) as patent_id from (select subcluster_id,(array_agg(patent_id))[1:5] as patent_ids from metrics_stage.kmeans_abstract_cluster_v13 group by 1)t)t1 inner join core.pats on pats.id = t1.patent_id) to /tmp/cluster_patent_mapping.csv with csv header
 
LOAD CSV WITH HEADERS FROM "file:///tmp/cluster_patent_mapping.csv" AS csvLine
MATCH (subcluster:Sub_Clusters { id: toInteger(csvLine.subcluster_id) })
CREATE (patent:Patents { id: toInteger(csvLine.patent_id), name:csvLine.patnum })
CREATE (patent)-[:belongs_to]->(subcluster)





LOAD CSV WITH HEADERS FROM "file:///tmp/cluster_vocabs_mapping.csv" AS csvLine
LOAD CSV WITH HEADERS FROM "file:///tmp/cluster_patent_mapping.csv" AS csvLine2
MERGE (subcluster:Sub_Clusters { name: csvLine.subcluster_name, id: toInteger(csvLine.subcluster_id) })
MERGE (vocab:Vocabs { name: csvLine.vocab })
MERGE (subcluster)-[:contains]->(vocab)
MERGE (patent:Patents { id: toInteger(csvLine2.patent_id), name:csvLine2.patnum })
MERGE (patent)-[:belongs_to]->(subcluster)
ON CREATE SET subcluster.name=csvLine.subcluster_name,
subcluster.id=toInteger(csvLine.subcluster_id),
vocab.name=csvLine.vocab,
patent.id=toInteger(csvLine2.patent_id),
patent.name=csvLine2.patnum
