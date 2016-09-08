.echo on
.output pairQuery2.log

select count(*) as airport_num from airport;

.print 'pair2 Or'
select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';
		
select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

.print 'pair2 in'; 
select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

explain query plan select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

explain query plan select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

.output stdout
.echo off
