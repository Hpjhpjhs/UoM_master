.echo on
.output pairQuery1.log

select count(*) as country_num from country;
select count(*) as organization_num from organization;
select count(*) as ismember_num from ismember;
select count(*) as city_num from city;

.print 'pair1 join'
select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;


.print 'pair1 cross join'
select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

explain query plan select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from country as c, organization as o, ismember as m, city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;

explain query plan select o.name as Organization, o.established, c.name as country, c.capital as capital, cit.name as city, cit.population
   from ismember as m cross join country as c cross join organization as o cross join city as cit
   where c.code = o.country and o.country = m.country and o.abbreviation = m.organization and cit.name = o.city;


.output stdout
.echo off
