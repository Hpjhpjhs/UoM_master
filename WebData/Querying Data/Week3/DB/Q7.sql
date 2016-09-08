.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--7. an intersection (∩) query
select name from bar
INTERSECT
select bar from serves;
