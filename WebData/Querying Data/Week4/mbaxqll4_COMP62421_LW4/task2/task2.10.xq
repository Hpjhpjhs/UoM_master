(:--10.Return the name of each country with the number of islands in it.
select c.name, count(geo.island) as num_island from country c join geo_island geo on c.code=geo.country group by geo.island;:)

for $c in doc('xml/mondial.xml')//country
let $num := count( doc('xml/mondial.xml')//island[tokenize(@country)=$c/@car_code] )
return concat($c/name, " ", $num)