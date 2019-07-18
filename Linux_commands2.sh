cal-calendar
passwd-change pwd
whoami-owner//who,users,w
logout-breaks connection
halt-Brings the system down immediately
init 0-Powers off the system using predefined scripts to synchronize and clean up the system prior to shutting down
init 6-Reboots the system by shutting it down completely and then restarting it
poweroff-Shuts down the system by powering off
reboot-Reboots the system
shutdown-Shuts down the system
-----------
file mang
------------
ls-listing
ls -l->listing dir and no. of files
ls -a->list of hidden files
vi-creating file/editing (vi filename)
l-key to move to the right side.
h-key to move to the left side.
k-key to move upside in the file.
j-key to move downside in the file
cat-display contents in files(cat filename)
wc-words counting(wc filename1 filename2 filename3)
cp-copy files(cp filename target)
mv-move(mv filename target) and rename(mv old new)
rm-deleting file
------------
dir mang
----------
cd-change directory
pwd-current wrkng dir
mkdir-make dir//(mkdir tmp/test-dir)-within a particular dir
rmdir-remove dir
mv-rename dir
chmod-changing dir access mode(+,-,=)
ls -l ->lists access for file(ls -l testfile)
chown-changing ownership(sudo chown manojprasanths:manojprasanths abc)
-----------
Unix Envir
------------
Echo-prints a line(Echo Test)
Variables-(PS1='=>')
----------------
Basic Utilities
----------------
pr-printing cmd(pr m.txt)
lp/lpq(printer status)-print through printer device
cancel/lprm(all)-to cancel printing 
mail-sending mail($mail -s "Test Message" admin@yahoo.com )
----------------
Pipes & Filters
----------------
pipe-(|)
grep-filter the matching pattern($ls -l | grep "Aug")
-v Prints all lines that do not match pattern.
-n Prints the matched line and its line number.
-l Prints only the names of files with matching lines (letter "l")
-c Prints only the count of matching lines.
-i Matches either upper or lowercase.

Sort-sort contents in files(-n,-r,-f)
pg-to view page order(ls .* | pg)
--------------
process mang
--------------
foreground-(ls ch*.doc) doesnt wait for input
background-(ls ch*.doc &)wait for input
ps-lists running process
kill-terminating process(Kill PID)
top-shows process,cpu usage,etc
-------------------
N/w Comm Utilities
-------------------
ping-connection status

------------
Vi Editor
------------
Vi filename-new file
Vi -R filename-opens in read only
View filename-opens in read only
Case Sensitive



Editing Cmds---
	i Inserts text before the current cursor location 
I Inserts text at the beginning of the current line 
a Inserts text after the current cursor location 
A Inserts text at the end of the current line 
o Creates a new line for text entry below the cursor location 
O Creates a new line for text entry above the cursor location

Deleting
i Inserts text before the current cursor location 
I Inserts text at the beginning of the current line 
a Inserts text after the current cursor location 
A Inserts text at the end of the current line 
o Creates a new line for text entry below the cursor location 
O Creates a new line for text entry above the cursor location

Change
cc Removes the contents of the line, leaving you in insert mode. 
cw Changes the word the cursor is on from the cursor to the lowercase w end of the word. 
r Replaces the character under the cursor. vi returns to the command mode after the	replacement is entered.
 R Overwrites multiple characters beginning with the character currently under the cursor. You must use Esc to stop the overwriting. 
s Replaces the current character with the character you type. Afterward, you are left in the insert mode.
 S Deletes the line the cursor is on and replaces it with the new text. After the new text is entered, vi remains in the insert mode.

Copy&Paste
yy Copies the current line. 
yw Copies the current word from the character the lowercase w cursor is on, until the end of the word.
 p Puts the copied text after the cursor. 
P Puts the yanked text before the cursor.

Joining
J-joins the line with nxt line

Searching
/- searches(/ pattern)




Shell

(#!/bin/sh)-denotes shell scripting follows
Comments -(# Script)# denotes comment line
Chmod +x-change to executable mode(to run in ./aa.sh format)
Echo-prints line
read-Reads the input from keyboard
----------------------------
Shell Variables
----------------------------
variable=variable value(NAME=”PERSON”)
Echo $NAME
readonly NAME-can’t change data
unset NAME-clears value of variable
Local,Shell,Environment?????

---------------------
Spl Variables
---------------------
echo "File Name: $0"---prints filename(echo "File Name: sample")

$0 The filename of the current script. 
$n prints the parameter values  $1…$9
$# The number of arguments supplied to a script. 
$*  like cat
$@ like cat
$? The exit status of the last command executed. 
$$ PID
$! The process number of the last background command.
----------
Do..done
-----------

for TOKEN in $*
do
 echo $TOKEN
done

------------
Array
-----------
array_name[n]=value------echo ${array_name[*]} / ${array_name[@]}
------------
Operators
-------------
val=`expr 2 + 2`--------------- echo "Total value : $val"
`expr $a + $b` 
if...then…..else......fi------if [ $a != $b ] 
then 
echo "a is not equal to b" 
fi
(-eq,-ne,-gt,-lt,ge,-le)

-----------
Boolean
-----------
!-NOT
-o-OR
-a-AND

--------------
Sring oper
--------------
=,!=,-z(zero),-n(non zero),str(empty check)

----------------------------
File Test Operators
----------------------------
if [ -f m.txt ]; then echo "true"; else echo "false"; fi

(-d(dir),-f(file),-r(readable),-w(write),-x(execute),-e(if exists),-s(size>0))


-------------------------------
C Shell Operators
-------------------------------
(-d(dir),-f(file),-r(readable),-w(write),-x(execute),-e(if exists),-s(size>0))

-------------------------------
Korn Shell Operators
-------------------------------
(-d(dir),-f(file),-r(readable),-w(write),-x(execute),-e(if exists),-s(size>0))



\---------------------
Decision Making
----------------------
if...fi statement 
if...else...fi statement  
if...elif...else...fi statement

if [ $a == $b ] 
then 
echo "a is equal to b" 
elif [ $a -gt $b ] 
then 
echo "a is greater than b" 
elif [ $a -lt $b ] 
then 
echo "a is less than b" 
else 
echo "None of the condition met" 
fi

----------------------------------
case...esac Statement
---------------------------------
#!/bin/sh 
FRUIT="kiwi" 
case "$FRUIT" in 
"apple") echo "Apple pie is quite tasty." 
;; 
"banana") echo "I like banana nut bread." 
;; 
"kiwi") echo "New Zealand is famous for kiwi." 
;; 
Esac










Until loop
========
we can use until loop in such a situation where we need to execute some statements until a condition is true.
Syntax:
until command
	do
	statements to be executed until condition become true
	done

a=0;
until [ ! $a -lt 10 ]
do
echo $a;
a=`expr $a + 1`;
done


select loop
========

we can use select loop to create a  menu driven program

eg:

a=5;
b=6;
select var in add mul sub
do
case $var in
add)
	echo `expr $a + $b`;;
mul)
	echo `expr $a \* $b`;
sub)
	echo `expr $a - $b`;;
*)
	echo “invalid”;;
esac
done



-- break # break statement is used to terminate the execution of loop
we can use break n to terminate nth loop
-- continue skips the current iteration of the loop

-- use of -e option with echo statement enables you the interpretation of backslash escapes.


escape sequences

\v - vertical tab
\t - horizontal tab
\n - new line
\f - form feed
\r - carriage return



variable substitution
===============

${var:-” ”} -- if the variable is unset or null the value is substituted the actual value don't change
${var:+” ”} -- if the variable is set then the value is substituted actual value don't change
${var:=” “} -- if the variable is null or unset the value is set to the variable 	
${var:?message} -- if the variable is not set it print an error with the message otherwise value of the variable will be printed

meta characters
===========

* ? [ ] ' " \ $ ; & ( ) | ^ < > new-line space tab


when using  single quotes all meta character lose its meaning..

when using double quotes all meta character lose its meaning except 
$, ` , /$, /’ , /”” , //

Standard output redirection
============

> --will redirect the output to a file
eg: who > users.txt 

⇒ tac is used for displaying the contents of a file in reverse order

Another ways to display the contents of a file in reverse order

nl file_name | sort -nr | cut -f 2-
	i=0 
2)
read file;
while read line[$i] ; do
    i=$(($i+1))
done < $file
for (( i=${#line[@]}-1 ; i>=0 ; i-- )) ; do
    echo ${line[$i]}


Input Redirection
=============

input of a command can be redirected from a file.
eg
wc -l < file_name



Here Document
============

Used to redirect input into an interactive shell script or program


eg: wc -l << EOF
hello world
hello 
eg:
writing data to vi

filename='test.txt';
echo $filename;
vi $filename <<abcde
i
This file was created automatically from
a shell script
`printf "\e"`
:wq


functions
=======


function_name()
	{
	statements;
	}

to call a function => function_name arg1 arg 2 ..

arguments($1- first arg ,$2 2nd arg …. so on)


we can define our on functions in .bashrc so it can be used each time we login.




finger
====
this command gives user informations


by using chfn we can change user informations.


netstat
======
netstat -a show all listening and non listening ports
netstat -l show all listening ports



ps
==
show information about the current process

ps -e // list all processes 

creating a user
===========
sudo useradd username
sudo passwd username

deleting a user
===========

sudo userdel username


sed(stream editor)
==============
used for text processing

during printing the processed line will print twice for removing that we use -n

to print datas in a file
sed -n ‘p’ file_name
to print only the second row
sed -n ‘2p’ file_name
to print all the row except 2nd row
sed -n ‘2!p’ file_name

to substitute a pattern

sed -e ‘s/word1/word2/` filename
 during substitution by default it only changes the first occurrence of a line 
we can use g option if we want to change all the occurrence.

to delete 2nd row from output

sed -e ‘2d’ filename
g - Replaces all matches, not just the first match
NUMBER - replace only NUMBER th match
p - it prints pattern space if substitution is made
w FILENAME - if substitution was made writes the result to FILENAME
i or I - matches in a case insensitive manner.
^$ -an empty line
^ - indicate line starting with
$ - indicate line ending with 

to delete empty lines 
	sed  -e '/^$/d' filename
to delete a specific word
	sed -e ‘/word/d’ filename


to delete spaces tabs empty lines

 sed  -e 's/\t//g' abc.txt | sed -e 's/ //g' | sed -e '/^$/d'

Alternative string separator
====================

We can replace the default delimiter with our delimiter
ie
sed -e ‘s:word1:word2:’ filename

to match words starting with alpha character
sed -n '/^[[:alpha:]]/p' abc.txt
[[:alnum:]] -- matches alphanumeric char
[[:digit:]] -- matches digits
[[:space:] -- matches spaces
[[:upper:]] -- matches uppercase letters
[[:xdigit:]] -- matches hex digit
[[:graph:]] -- matches any visible character except whitespace
[[:blank:]] -- matches blank characters space or tab.


& -- represent contents of the pattern that was matched for


sed -e 's/[[:digit:]][[:digit:]][[:digit:]]/(&)/' number.txt

here & represent first 3 digit.


Back references 
============


 sed 's/\(.*)\)\(.*-\)\(.*$\)/Area code :\1 second \2 third \3/' number.txt

We use back slashed parentheses to define a region and the use \1 \2 … to reference that region.



  

df -k // show disk space usage
head //output first part of file.
tail //output last part of file.
du // can be used to find disk usage of a directory or file 
eg : du -h dirname
find filename dirname // find a file or directory
touch filename // create an empty file

useradd username // to add a new user
passwd username // to set password 
userdel username //to delete user
groupadd groupname // create a new user group
groupdel groupname // delete a user group.
groupmod //modify group attributes
sudo usermod -aG sudo username // give sudo privilege to the user

/etc/passwd --stores user account and password information
/etc/shadow -- stores user passwords($1$: it uses MD5.
$5$: it uses SHA-256.
$6$: it uses SHA-512.
)

/etc/group − This file contains the group information for each account.

/etc/gshadow − This file contains secure group account information.


to print the frequency of word in a file

 cat m.txt | tr ' ' '\n' | sort | uniq -ic
or
awk '{for(w=1;w<=NF;w++) print $w}' m.txt | sort | uniq -c | sort -n


for login via ssh we need to install  openssh-server openssh-client in the target machine
then
login using  sudo ssh  username@host.

for sharing screen use remmina.. but before using remmina enable desktop sharing from dashboard
then open remmina create connection using virtual network computing VNC



//code to display comma seperated fields as a single row.
awk -F ',' -v q="'" -v l="{" -v r="}" '{col1=col1$1","; col2=col2$2",";} 
END {gsub(",$","",col1);gsub(",$","",col2);print q l col1 r q"," q l col2 r q;}' test.txt


echo `cat abc.txt | awk -F',' '{print $1,","}'| tr -d "\n" | sed -e 's/,$/}/g' | 
sed -e 's/^/{/'; cat abc.txt | awk -F',' '{print $2,","}'| tr -d "\n" | sed -e 's/,$/}/g' | 
sed -e 's/^/{/'`;

for (( i=1; i<=2; i++ )); do     awk -v i="$i" -F , '{printf("%s,",$i)}' check.txt;
echo; done|awk '{print "{"$0""}' |sed 's/.$/}/'

awk -F"," '{ for (i = 1; i <= NF; i++) f[i] = f[i] "," $i ;
       if (NF > n) n = NF }
 END { for (i = 1; i <= n; i++) sub(/^, */,"", f[i]) ;
       for (i = 1; i <= n; i++) print f[i] }
    ' check.txt |awk '{print "{"$0"}"}'
    
    
    
    
    ctrl + R -- to serach a command in history
    !id -- to run a previous command from history that having an id
    vimtutor -- to learn vim commands
    



