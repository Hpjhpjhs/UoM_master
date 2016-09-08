declare default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el";
declare namespace ssd="http://www.cs.manchester.ac.uk/pgt/COMP60411/";
(: You should define a *function* ssd:axiom, that takes a node and returns true if that node is an axiom,
e.g., an instance-of, subsumes, etc. element. :)

import schema default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el" at "el.xsd";

declare function ssd:axiom ( $axm as element() )
as xs:boolean
{
    if( $axm instance of element(ssd:equivalent) )
        then fn:true()
        else fn:false()
};

for $t in doc("el1.xml")/element(*,ssd:equivalent)
return
if(ssd:axiom($t))
then $t
else fn:false()
