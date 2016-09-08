--1.Return names of countries that are not landlocked (i.e., have a sea coast).
select distinct c.name from country c join geo_sea s on c.code = s.country;

--2.Return the names of all lakes, rivers and seas.
select name from lake UNION select name from river UNION select name from sea;

--3.Return the average length over all the river.
select avg(length) from river;

--4.Return the name of countries that have more than 10 islands.
select c.name from country c join geo_island i on c.code=i.country group by i.country having count(i.country) > 10;

--5.Return, for every river in Great Britian, the length of that river.
select r.name, r.length from geo_river gr join river r on gr.river=r.name where gr.country='GB';

--6.Return the name of the countries that have the 10 longest total length of rivers.
select name, sum(length) as total_length from (select distinct c.name, r.length from country c, geo_river gr, river r where c.code=gr.country and gr.river = r.name) group by name order by total_length desc limit 10;

--7.Return all the information available about cities whose name is Manchester.
select * from City where name='Manchester';

--8.Return the name of cities whose name starts with the substring 'Man’.
select name from city where name like 'Man%';

--9.Return the name of the country and the name of the organization of countries with Buddhist populations that are members of organizations established after 1st December 1994.
select c.name as country, o.name from country c, organization o, ismember im, religion re where im.organization = o.abbreviation and c.code = im.country and re.country=c.code and o.established > '1994-12-01' and re.name = 'Buddhist';

--10.Return the name of each country with the number of islands in it.
select c.name, count(geo.island) as num_island from country c join geo_island geo on c.code=geo.country group by geo.island;

