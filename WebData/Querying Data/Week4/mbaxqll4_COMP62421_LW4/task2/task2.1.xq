(:--1.Return names of countries that are not landlocked (i.e., have a sea coast).
select distinct c.name from country c join geo_sea s on c.code = s.country;:)


distinct-values(
for $c in  doc('xml/mondial.xml')//country
let $code := $c/@car_code
for $geo_sea in doc('xml/mondial.xml')//sea/tokenize(@country)
where $code = $geo_sea
return $c/name
)
