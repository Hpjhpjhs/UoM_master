declare default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el";
declare namespace ssd="http://www.cs.manchester.ac.uk/pgt/COMP60411/";
(:You should define a *function* ssd:classexpression, that takes a node and returns true if that node is an class expression,
e.g., a conjunction element. :)

declare function ssd:classexpression ( $node as node() )
{
    let $calexp := doc("el1.xml")//( atomic, conjunction, exists )
    return 
    if( $node = $calexp and  (fn:name($node) != 'constant'))
    then fn:true()
    else fn:false()
};

for $child in doc("el1.xml")//element()
where ssd:classexpression($child)
return $child