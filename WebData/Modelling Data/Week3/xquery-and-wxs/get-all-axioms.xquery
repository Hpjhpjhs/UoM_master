declare default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el";
(: You should have a single (if somewhat complex) XPath expression here :)

import schema default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el" at "el.xsd";
if (validate {doc("el1.xml")}) 
   then //(equivalent | subsumes | instance-of | related-to)
   else flase