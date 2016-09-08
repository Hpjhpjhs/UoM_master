(:--2.Return the names of all lakes, rivers and seas.
select name from lake
UNION
select name from river
UNION
select name from sea;

let $l := //lake/name/text()
let $r := //river/name/text()
let $s := //sea/name/text()
return $l union $r union $s

let $l := doc('xml/converted/a/lake_a.xml')//lake-tuple/@name
let $r := doc('xml/converted/a/river_a.xml')//river-tuple/@name
let $s := doc('xml/converted/a/sea_a.xml')//sea-tuple/@name
return $l union $r union $s
:)

let $l := doc('xml/converted/e/lake_e.xml')//lake-tuple/name
let $r := doc('xml/converted/e/river_e.xml')//river-tuple/name
let $s := doc('xml/converted/e/sea_e.xml')//sea-tuple/name
return $l union $r union $s
