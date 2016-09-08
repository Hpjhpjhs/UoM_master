import schema default element namespace "" at "flashcardhtml.xsd";
import schema namespace q="http://www.cs.manchester.ac.uk/pgt/COMP60411/examples/quiz" at "quiz.xsd";

declare function local:expr2humanReadable($expr) {
    let $x := (
        if($expr instance of element(q:expr))
        then fn:concat( (local:expr2humanReadable($expr/*[1])),'' )
        else if($expr instance of element(q:plus) )
        then fn:concat( '(', local:expr2humanReadable($expr/*[1]), ' + ' , local:expr2humanReadable($expr/*[2]), ')' )
        else if($expr instance of element(q:times) )
        then fn:concat( '(', local:expr2humanReadable($expr/*[1]), ' * ', local:expr2humanReadable($expr/*[2]), ')' )
        else if($expr instance of element(q:minus) )
        then fn:concat( '(', local:expr2humanReadable($expr/*[1]), ' - ', local:expr2humanReadable($expr/*[2]), ')' )
        else if($expr instance of element(q:dividedBy) )
        then fn:concat( '(', local:expr2humanReadable($expr/*[1]), ' / ', local:expr2humanReadable($expr/*[2]), ')' )
        else if($expr instance of element(q:number))
        then fn:concat( $expr, '' )
        else 0
    )
    return $x
};

declare function local:answerFor($expr) {
   let $result := (
        if($expr instance of element(q:expr))
        then (local:answerFor($expr/*[1]))
        else if($expr instance of element(q:plus) )
        then ( (local:answerFor($expr/*[1])) + (local:answerFor($expr/*[2])) )
        else if($expr instance of element(q:times) )
        then ( (local:answerFor($expr/*[1])) * (local:answerFor($expr/*[2])) )
        else if($expr instance of element(q:minus) )
        then ( (local:answerFor($expr/*[1])) -  (local:answerFor($expr/*[2])) )
        else if($expr instance of element(q:dividedBy) )
        then ( (local:answerFor($expr/*[1])) div (local:answerFor($expr/*[2])) )
        else if($expr instance of element(q:number))
        then $expr
        else 0
    )
    return $result
};

validate{<html>
    <head>
        <title>{/*/q:title/text()}</title>
        <script type="text/javascript" src="miniformvalidator.js"/>
    </head>
    <body>
        <h1>{/*/q:title/text()}</h1>
        <form>
            <ol>{let $exprs := /*/q:expr, 
                     $count := count($exprs)
                 for $i in (1 to $count)
                 let $expr := $exprs[$i]
                 let $id := concat("q", $i)
                 return <li>{local:expr2humanReadable($expr)}=
                <input type="text" id="{$id}" data-answer="{local:answerFor($expr)}" size="8" /><span><input
                        type="button" onclick="check(document.getElementById('{$id}'))"
                        value="Check answer" /></span>
                </li>}
            </ol>
        </form>
    </body>
</html>}