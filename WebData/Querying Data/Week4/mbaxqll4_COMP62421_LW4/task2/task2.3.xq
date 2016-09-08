(:--3.Return the average length over all the river.
select avg(length) from river;:)

let $l := doc('xml/mondial.xml')//river/length/text()
return avg($l)