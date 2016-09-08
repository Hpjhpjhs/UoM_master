(:--2.Return the names of all lakes, rivers and seas.
select name from lake
UNION
select name from river
UNION
select name from sea;
:)

let $l := doc('xml/mondial.xml')//lake/name/text()
let $r := doc('xml/mondial.xml')//river/name/text()
let $s := doc('xml/mondial.xml')//sea/name/text()
return $l union $r union $s
