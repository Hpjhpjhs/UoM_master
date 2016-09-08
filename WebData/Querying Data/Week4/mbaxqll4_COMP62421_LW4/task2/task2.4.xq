(:--4.Return the name of countries that have more than 10 islands.
select c.name from country c join geo_island i on c.code=i.country group by i.country having count(i.country) > 10;:)

for $c in doc('xml/mondial.xml')//country
where count( doc('xml/mondial.xml')//island[tokenize(@country)=$c/@car_code]/@id ) > 10
return $c/name/text()