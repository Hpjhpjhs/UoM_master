--SQL expressions:
.mode csv
--(12)Return the names of up to 10 countries and the value corresponding to half the country’s population.
select name, (population/2) as half_of_population 
from country limit 10;

--
--(13)Return all the information available about cities whose name is Manchester.
select * from City 
where name='Manchester';

--
--(14)Return the name of cities whose name starts with the substring 'Man’.
select name from city 
where name like 'Man%';


--(15)Return the name of both countries with Buddhist populations and organizations, established after 
select c.name as country, mem.organization 
	from country c join 
	(select distinct m.country as country_code, o.name as organization 
		from organization o join ismember m on m.organization=o.abbreviation 
		where o.established > '1994-12-01' 
		and m.country in ( select country from religion 
		where name='Buddhist' ) ) mem 
	on c.code = mem.country_code;

--
--(16)Return the name of each country with the number of islands in it.
select c.name, count(geo.island) as num_island 
from country c 
join geo_island geo 
on c.code=geo.country 
group by geo.island;
