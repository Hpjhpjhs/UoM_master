declare default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el";
declare namespace ssd="http://www.cs.manchester.ac.uk/pgt/COMP60411/";
(: You should define a *function* ssd:axiom, that takes a node and returns true if that node is an axiom,
e.g., an instance-of, subsumes, etc. element. :)

declare function ssd:axiom ( $node as node() )
{
    let $axm := doc("el1.xml")//(equivalent | subsumes | instance-of | related-to)
    return 
    if( $node = $axm )
    then fn:true()
    else fn:false()
};

for $child in doc("el1.xml")//element()
where ssd:axiom($child)
return $child