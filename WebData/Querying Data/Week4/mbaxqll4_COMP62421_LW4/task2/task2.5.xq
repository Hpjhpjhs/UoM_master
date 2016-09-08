(:--5.Return, for every river in Great Britian, the length of that river.
select r.name, r.length from geo_river gr join river r on gr.river=r.name where gr.country='GB';:)

for $r in doc('xml/mondial.xml')//river[tokenize(@country)='GB']
return $r/length