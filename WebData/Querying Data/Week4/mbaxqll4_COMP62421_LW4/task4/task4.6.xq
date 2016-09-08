(:--6.Return the name of the countries that have the 10 longest total length of rivers.
select distinct c.name from country c, geo_river gr, river r where c.code=gr.country and gr.river = r.name order by r.length desc limit 10;

(for $c in //country
let $l := sum( //river[tokenize(@country)=$c/@car_code]/length/text() )
order by $l descending
return concat($c/name, " ", $l)
)[position()<=10]
:)

(for $c in doc('xml/converted/e/country_e.xml')//country-tuple
let $r := distinct-values( doc('xml/converted/e/geo_river_e.xml')//geo_river-tuple[country=$c/code]/river )
let $l := sum( data( doc('xml/converted/e/river_e.xml')//river-tuple[name=$r and length != 'MISSING']/length ) )
order by $l descending
return concat($c/name, " ", $l)
)[position()<=10]