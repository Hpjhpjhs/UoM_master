(:--5.Return, for every river in Great Britian, the length of that river.
select r.name, r.length from geo_river gr join river r on gr.river=r.name where gr.country='GB';

for $r in //river[tokenize(@country)='GB']
return $r/length

for $gr in doc('xml/converted/a/geo_river_a.xml')//geo_river-tuple[@country='GB']
for $r in doc('xml/converted/a/river_a.xml')//river-tuple[@name=$gr/@river]
return  concat($r/@name, " ", $r/@length)
:)

for $gr in doc('xml/converted/e/geo_river_e.xml')//geo_river-tuple[country='GB']
for $r in doc('xml/converted/e/river_e.xml')//river-tuple[name=$gr/river]
return  concat($r/name, " ", $r/length)