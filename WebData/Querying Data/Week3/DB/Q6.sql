.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--6. a union (∪) query
select * from bar
UNION
select bar, price from serves;

