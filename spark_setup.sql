SPARK SET UP:
    Master should have ssh connection to all worker nodes.
	we choose "spark" user to be common across all nodes.
	
	Master and worker Node installation is same.
		 in Master. we set up "slaves" file in /opt/rpx/spark/conf/slaves
		 this file has the host/cnames of the worker file. it is used to lookup when we start or stop the cluster.
		 
		 Master also has few additonal parameters in /opt/rpx/spark/conf/spark_env.sh
		  we set the Python version to use.
		  any global variables that have to loaded when spark starts.
		  how many max cores etc. lot of properties we set a few.
		  cleanign up the work space properties. 
		  SPARK_WORKER_OPTS="-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.interval=1800  -Dspark.worker.cleanup.appDataTtl=172800" 2 days.
		  refer --https://spark.apache.org/docs/latest/spark-standalone.html
		 
	 on worker nodes:
		 we just have to ensure the following are set
		 export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
		 Optional parameter to limit how many are available for spark : export SPARK_WORKER_CORES=8
		 
	 Cluster Operations: go to /opt/rpx/spark/sbin
		  Start entire cluster :  start-all.sh
		  stop entire cluster : stop-all.sh
		  
		  Add a new worker node to cluster : on the worker node run the following.
		  /opt/rpx/spark/sbin/start-slave.sh  spark://<master>.local:7077
		  
		  Remove a worker from cluster : on the worker node run the following
		  /opt/rpx/spark/sbin/stop-slave.sh
		  
		  if multiples nodes are down.you can also do the following instead of starting worker nodes individually.
		  from master run 
		  /opt/rpx/spark/sbin/start-all.sh
		  it will throw warning if the worker is already running else start it.
	  
	  SPARK Work Space:
		by default the spark work space is on root volume or based on the installation path.
		since our root volumes are small. depending on the load and autoclean up process we might run out space.
		for us it is "/opt/rpx/spark/work/".  
	  
		what we have done is create this path as a symbolic link and actually have the work space on data disk.
	  
	  clean up script:
		cd /opt/rpx/spark/work/
		ls -1|grep -v "<your app id in spark ui"|xargs rm -rf

	  Jupyter:
		we need to have jupyter installed on Master in order to develop jobs on cluster.
		default password is "rpxdatateam"
	  
	  command to start jupyter if not running:
		sudo su - spark
		cd  /opt/rpx/repos    # start the jupyter from your repo directory to easily access only code.
		jupyter notebook --no-browser --port=8082  > /spark_shared/jupyter/notebook.log 2>&1 & 
		
Utilities on Master Node spark home directory:
	check_size_of_folder.sh	 : this will go through the list of servers on the installnodes file and report the work directory size. some time we may have to clean this up manually to recover some space.
		no arugments required.
	run_command_on_each_spark_worker_node.sh: use this to install python libaries on worker nodes
		takes one command in quotes.
	
	scp_to_slave.sh : copy a file from master node to the worker nodes.  takes two parameters 
	
	Other scripts : are used by OPS to create new nodes etc. 
	
SPARK UI: 8081
  to see which nodes are up.
  which jobs are running.

Spark Detailed UI:4040+n
  details on the job, its stages, cache, number of executors allocated. their status.