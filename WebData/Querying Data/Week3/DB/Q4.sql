.timer on
.nullvalue NULL 

.output /home/mbaxqll4/Documents/QueryingData/Week3/DB/re.log

.echo on

--4. if possible, reuse the previous query and ensure duplicate (δ) removal
select distinct * from Bar, Serves;

