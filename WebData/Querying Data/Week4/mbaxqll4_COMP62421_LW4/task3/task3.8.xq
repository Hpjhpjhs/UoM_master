(:--8.Return the name of cities whose name starts with the substring 'Man’.
select name from city where name like 'Man%';

for $cn in //city/name/text()
where starts-with( $cn, 'Man')
return $cn
:)

for $cn in doc('xml/converted/a/city_a.xml')//city-tuple/@name
where starts-with( $cn, 'Man')
return $cn
