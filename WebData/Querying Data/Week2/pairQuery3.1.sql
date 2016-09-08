.echo on
.output pairQuery3_1.log

select count(*) from airport;

.print 'pair3 Like'
select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';

select * from airport where city like 'Man%';


.print 'pair3 and without index'
select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';
	
select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';

select * from airport where city>='Man' and city<'Mao';


explain query plan select * from airport where name like 'Man%';

explain query plan select * from airport where name>='Man' and name<'Mao';

.output stdout
.echo off
