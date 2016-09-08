.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--1. simple selection (σ) query over a single relation
select * from Bar where name like 'T%';
