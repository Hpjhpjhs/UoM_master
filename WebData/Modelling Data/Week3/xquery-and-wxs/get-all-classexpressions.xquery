declare default element namespace "http://www.cs.manchester.ac.uk/pgt/COMP60411/el";
(: You should have a single (if somewhat complex) XPath expression here :)

if (validate {doc("el1.xml")}) 
   then //( atomic | conjunction | exists )
   else flase
