(:--6.Return the name of the countries that have the 10 longest total length of rivers.
select distinct c.name from country c, geo_river gr, river r where c.code=gr.country and gr.river = r.name order by r.length desc limit 10;:)

(for $c in doc('xml/mondial.xml')//country
let $l := sum( doc('xml/mondial.xml')//river[tokenize(@country)=$c/@car_code]/length/text() )
order by $l descending
return concat($c/name, " ", $l)
)[position()<=10]
