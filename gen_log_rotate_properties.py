import sys,os,time,operator
import csv
from datetime import datetime
# 1.0 akozhinjalthodi 04-Dec-2017 DS-6244: New Python File to Generate the logrotate property file based on csv
#
# python /opt/pentaho/repos/pentaho_misc/current/log_rotate/bin/gen_log_rotate_properties.py /opt/pentaho/repos/pentaho_misc/log_rotate/input/etl_log_config.csv /opt/pentaho/repos/pentaho_misc/log_rotate/config
#
# --test.csv--
# id,name,path,rotate,size,user,group
# 1,cp_etl_logs,/var/log/kettle/cp_etl_logs,5,100M,kettle,kettle
# 2,insights_etl_logs,/var/log/kettle/insights_etl,5,100M,kettle,kettle

file_obj=sys.argv[1]
f=open(sys.argv[2] + '/etl_log_configs','w'); #Create config file
f.write('#File Generated at : '+str(datetime.now())+'\n')

with open(file_obj, 'rb') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
	next(spamreader,'none') #Skipping header row
	sortedlist = sorted(spamreader, key=operator.itemgetter(0)) #sorting csv file based on id
	for row in sortedlist:
		f.write('#'+row[0]+' '+row[1]+'\n#-----------------\n')
		f.write(row[2] + ' {' + '\n')
		f.write('\tmissingok\n');
		f.write('\trotate '+row[3]+'\n')
		f.write('\tcompress\n');
		f.write('\tsize '+row[4]+'\n')
		f.write('\tnotifempty\n')
		f.write('\tcreate 640 '+row[5]+ ' '+ row[6]+'\n')
		f.write('\tpostrotate\n \t\techo "`date`+'+' ' +row[0]+' '+row[1]+'\t$1\tLogs Rotated" >>'+sys.argv[2]+'gen_log_rotate_properties.log'+'\n\tendscript\n}\n\n');
        
print("Log File Generated");
