.echo on
.output pairQuery1.log

.print 'pair1 join'
select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

.print 'pair1 cross join'
select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

explain query plan select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

explain query plan select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

----------------------------------------------------------------------------------------------------
.output pairQuery2.log

.print 'pair2 Or'
select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

.print 'pair2 in'; 
select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

explain query plan select * from airport where city='Beijing' or city='Shanghai' or city='Guangzhou';

explain query plan select * from airport where city in('Beijing', 'Shanghai', 'Guangzhou');

----------------------------------------------------------------------------------------------------
.output pairQuery3.log

select count(*) from city;

.print 'pair3 Like'
select * from city where name like 'Man%';

.print 'pair3 and'
select * from city where name>='Man' and name<'Mao';

explain query plan select * from city where name like 'Man%';

explain query plan select * from city where name>='Man' and name<'Mao';


.output stdout
.echo off