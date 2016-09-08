.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--5. if possible, reuse the previous query and instead of Cartesian product, used the natural join (⋈)
select distinct * from Bar b, Serves s where b.name = s.bar;

