(:--7.Return all the information available about cities whose name is Manchester.
select * from City where name='Manchester';

//city[name='Manchester']

doc('xml/converted/a/city_a.xml')//city-tuple[@name='Manchester']
:)

doc('xml/converted/e/city_e.xml')//city-tuple[name='Manchester']