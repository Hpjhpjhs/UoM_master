(:--1.Return names of countries that are not landlocked (i.e., have a sea coast).
select distinct c.name from country c join geo_sea s on c.code = s.country;

distinct-values(
for $c in //country
let $code := $c/@car_code
for $geo_sea in //sea/tokenize(@country)
where $code = $geo_sea
return $c/name
)

distinct-values(
for $c in doc('xml/converted/a/country_a.xml')//country-tuple
for $geo in doc('xml/converted/a/geo_sea_a.xml')//geo_sea-tuple
where $c/@code = $geo/@country
return $c/@name
)
:)

distinct-values(
for $c in doc('xml/converted/e/country_e.xml')//country-tuple
for $geo in doc('xml/converted/e/geo_sea_e.xml')//geo_sea-tuple
where $c/code = $geo/country
return $c/name)
