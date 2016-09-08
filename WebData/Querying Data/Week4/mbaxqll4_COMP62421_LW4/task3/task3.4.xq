(:--4.Return the name of countries that have more than 10 islands.
select c.name from country c join geo_island i on c.code=i.country group by i.country having count(i.country) > 10;

for $c in //country
where count(//island[tokenize(@country)=$c/@car_code]/@id ) > 10
return $c/name/text()
:)

for $c in doc('xml/converted/a/country_a.xml')//country-tuple
where count( doc('xml/converted/a/geo_island_a.xml')//geo_island-tuple[@country=$c/@code] ) > 10
return $c/@name
