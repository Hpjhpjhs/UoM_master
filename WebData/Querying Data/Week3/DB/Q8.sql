.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--8. an aggregation (γ) query
select drinker, count(times_a_week) as total_times from frequents group by drinker;
