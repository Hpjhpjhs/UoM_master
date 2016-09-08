.timer on
.mode column
.header on
.nullvalue NULL 	
.echo on
.output out.log

--Bar(name, address); 
--Beer(name, brewer); 
--Drinker(name, address); 
--Frequents(drinker, bar, times_a_week);
--Likes(drinker, beer);
--Serves(bar, beer, price); 

--1. simple selection (σ) query over a single relation
select * from Bar where name like 'T%' ;

--2. a simple projection (π) query over a single relation
select drinker, times_a_week from Frequents;

--3. a σ query over the Cartesian product1 (×) of two relations
select * from Drinker, Likes;

--4. if possible, reuse the previous query and ensure duplicate (δ) removal
select distinct * from Drinker, Likes;

--5. if possible, reuse the previous query and instead of Cartesian product, used the natural join (⋈)
select distinct * from Drinker d, Likes l where d.name = l.drinker;

--6. a union (∪) query
select * from Drinker
UNION
select * from Likes;

--7. an intersection (∩) query
select drinker from Frequents
INTERSECT
select drinker from Likes;

--8. an aggregation (γ) query
select drinker, count(times_a_week) as total_times from frequents group by drinker;
