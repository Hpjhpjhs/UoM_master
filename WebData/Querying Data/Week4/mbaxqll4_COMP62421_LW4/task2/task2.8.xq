(:--8.Return the name of cities whose name starts with the substring 'Man’.
select name from city where name like 'Man%';:)

for $cn in doc('xml/mondial.xml')//city/name/text()
where starts-with( $cn, 'Man')
return $cn