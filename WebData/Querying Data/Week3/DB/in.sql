.timer on
.mode column
.header on
.nullvalue NULL 	
.echo on
.output queryResult.log

--Bar(name, address); 
--Beer(name, brewer); 
--Drinker(name, address); 
--Frequents(drinker, bar, times_a_week);
--Likes(drinker, beer);
--Serves(bar, beer, price); 

--1. simple selection (σ) query over a single relation
select * from Bar where name like 'T%';

--2. a simple projection (π) query over a single relation
select name from bar;

--3. a σ query over the Cartesian product1 (×) of two relations
select * from Bar, Serves;

--4. if possible, reuse the previous query and ensure duplicate (δ) removal
select distinct * from Bar, Serves;

--5. if possible, reuse the previous query and instead of Cartesian product, used the natural join (⋈)
select distinct * from Bar b, Serves s where b.name = s.bar;

--6. a union (∪) query
select * from bar
UNION
select bar, price from serves;

--7. an intersection (∩) query
select name from bar
INTERSECT
select bar from serves;

--8. an aggregation (γ) query
select drinker, count(times_a_week) as total_times from frequents group by drinker;
