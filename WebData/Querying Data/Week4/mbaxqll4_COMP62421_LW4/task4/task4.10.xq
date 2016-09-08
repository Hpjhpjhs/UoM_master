(:--10.Return the name of each country with the number of islands in it.
select c.name, count(geo.island) as num_island from country c join geo_island geo on c.code=geo.country group by geo.island;

for $c in //country
let $num := count( //island[tokenize(@country)=$c/@car_code] )
return concat($c/name, " ", $num)

for $c in doc('xml/converted/a/country_a.xml')//country-tuple
let $num := count( doc('xml/converted/a/geo_island_a.xml')//geo_island-tuple[@country=$c/@code] )
return concat($c/@name, " ", $num)
:)

for $c in doc('xml/converted/e/country_e.xml')//country-tuple
let $num := count( doc('xml/converted/e/geo_island_e.xml')//geo_island-tuple[country=$c/code] )
return concat($c/name, " ", $num)
