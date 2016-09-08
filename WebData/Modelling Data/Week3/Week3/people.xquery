import schema default element namespace "" at "persontypes.xsd";
for $person in (validate { doc("personInstance1.xml")})//element(*,LongPersonType)[@friend=boolean("false")]
return
      <person>
             <Name> {$person/Name} </Name>
      </person> 