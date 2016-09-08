(:--3.Return the average length over all the river.
select avg(length) from river;

let $l := //river/length/text()
return avg($l)


let $l := data( doc('xml/converted/a/river_a.xml')//river-tuple[@length != 'MISSING']/@length )
return avg($l)
:)

let $l := data( doc('xml/converted/e/river_e.xml')//river-tuple[length != 'MISSING']/length )
return avg($l)