(:--9.Return the name of the country and the name of the organization of countries with Buddhist populations that are members of organizations established after 1st December 1994.
select c.name as country, o.name from country c, organization o, ismember im, religion re
where im.organization = o.abbreviation and c.code = im.country and re.country=c.code and 
o.established > '1994-12-01' and re.name = 'Buddhist';

for $c in //country[religion='Buddhist']
let $member := tokenize($c/@memberships)
for $o in //organization[@id=$member and established > '1994-12-01' ]
return concat($c/name, " ---- ", $o/name)
:)

for $r in doc('xml/converted/a/religion_a.xml')//religion-tuple[@name='Buddhist']/@country
for $c in doc('xml/converted/a/country_a.xml')//country-tuple[@code=$r]
let $member := doc('xml/converted/a/ismember_a.xml')//ismember-tuple[@country=$c/@code]/@organization
for $o in doc('xml/converted/a/organization_a.xml')//organization-tuple[@abbreviation=$member and @established > '1994-12-01']
return concat($c/@name, " ---- ", $o/@name)
