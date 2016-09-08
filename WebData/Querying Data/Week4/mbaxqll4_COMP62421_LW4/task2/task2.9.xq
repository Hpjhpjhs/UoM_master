(:--9.Return the name of the country and the name of the organization of countries with Buddhist populations that are members of organizations established after 1st December 1994.
select c.name as country, o.name from country c, organization o, ismember im, religion re
where im.organization = o.abbreviation and c.code = im.country and re.country=c.code and 
o.established > '1994-12-01' and re.name = 'Buddhist';:)

for $c in doc('xml/mondial.xml')//country[religion='Buddhist']
let $member := tokenize($c/@memberships)
for $o in doc('xml/mondial.xml')//organization[@id=$member and established > '1994-12-01' ]
return concat($c/name, " ---- ", $o/name)