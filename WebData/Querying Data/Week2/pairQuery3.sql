.echo on
.output pairQuery3.log

select count(*) from city;

.print 'pair3 Like'
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';
select * from city where name like 'Man%';

.print 'pair3 and'
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';
select * from city where name>='Man' and name<'Mao';

explain query plan select * from city where name like 'Man%';

explain query plan select * from city where name>='Man' and name<'Mao';

.output stdout
.echo off
