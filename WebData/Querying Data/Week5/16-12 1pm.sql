16-12 1pm

select distinct ?c
where {
?c a dbo:City.
}
can get URI related to all entity that has a type: dbo:City

Get all information of city which name is Manchester
select distinct ?c
where {
?c a dbo:City;
 foaf:name "Manchester"@en.
}
Return the same city as in RA, but much more information from the link

select distinct ?c ?nm
where {
?c a dbo:City;
 foaf:name ?nm.
filter( regex( ?nm, '^Man', 'i') )
}
order by ?nm


PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>        
PREFIX type: <http://dbpedia.org/class/yago/>
PREFIX prop: <http://dbpedia.org/property/>
SELECT ?country_name
WHERE {
    ?c a dbo:Country;
             rdfs:label ?country_name .
FILTER (langMatches(lang(?country_name), "EN"))
}

Get all country
SELECT ?c
WHERE {
    ?c a dbo:Country
}

Return 1694 URIs, but including a lot of organisation, team, and society

SELECT ?c
WHERE {
    ?c a dbo:Country;
dbo:capital ?cap.
}
Return 858 URIs, filter place that do not have capital

SELECT distinct ?c
WHERE {
    ?c a dbo:Country;
dbo:capital ?capi;
dbo:leader ?l
}
242 URIs, filter out some districts like England, Scotland, but will except countries that have no capital and leader.


PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT distinct ?c ?nm
WHERE {
    ?c a dbo:Country;
dbo:capital ?capi;
dbo:leader ?l.
?c rdfs:label ?nm.
FILTER (langMatches(lang(?nm), "EN"))
}
