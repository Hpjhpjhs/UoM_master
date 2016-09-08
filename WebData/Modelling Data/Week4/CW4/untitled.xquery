xquery version "1.0";
declare namespace bjp = 'http://ex.org';
(:

declare variable $d := doc("testsuper.xml");

(: get prefix and uri of namespace within a node :)
declare function bjp:nsBindingForNode($node)
{
    for $prefix in fn:in-scope-prefixes($node)
    for $ns in fn:namespace-uri-for-prefix($prefix, $node)
    order by $prefix ascending
    return <nsb pre="{$prefix}" ns="{$ns}"/>
};


(: same URI with different prefixes in same scope :)
declare function bjp:multiPrefixedNs($bindings)
{
 for $b in $bindings
 for $b2 in $bindings
 where not($b/@pre = $b2/@pre) and ($b/@ns = $b2/@ns)
 return <multi>{$b} {$b2}</multi>
};
(:test super confusing:)
declare function bjp:isSuperConfusing()
{
    for $n in $d//*
    for $m in bjp:multiPrefixedNs(bjp:nsBindingForNode($n))
    return 'YES - it is superconfusing!'
};


(: same URI with different prefixes in different scope :)
declare function bjp:multiPrefixes($n1, $n2)
{   
    for $b1 in bjp:nsBindingForNode($n1)
    for $b2 in bjp:nsBindingForNode($n2)
    where ($b1/@pre != $b2/@pre) and ( $b1/@ns = $b2/@ns)
    return <multi>{$b1}in{$n1} and {$b2}{$n2} are deceptive</multi>
};
(:test confusing:)
declare function bjp:isConfusing()
{
    for $n1 in $d//*
    for $n2 in $d//*
    where bjp:multiPrefixes($n1, $n2)
    return 'YES - it is confusing!'
};

fn:distinct-values( bjp:isConfusing() )



(: get prefix and uri of namespace within a node :)
declare function bjp:nsBindingForNode($node)
{
    for $prefix in fn:in-scope-prefixes($node)
    for $ns in fn:namespace-uri-for-prefix($prefix, $node)
    order by $prefix ascending
    return <nsb pre="{$prefix}" ns="{$ns}"/>
};
(: same prefix with different URI in different scope :)
declare function bjp:multiURI($n1, $n2)
{   
    for $b1 in bjp:nsBindingForNode($n1)
    for $b2 in bjp:nsBindingForNode($n2)
    where ($b1/@pre = $b2/@pre) and ( $b1/@ns != $b2/@ns)
    return <multi>{$b1}in{$n1} and {$b2}{$n2} are deceptive</multi>
};
(:test deceptive:)
declare function bjp:isDeceptive()
{
    for $n1 in $d//*
    for $n2 in $d//*
    where bjp:multiURI($n1, $n2)
    return 'YES - it is deceptive!'
};

:)

    for $n in //*
    for $prefix in fn:in-scope-prefixes( $n )
    for $ns in fn:namespace-uri-for-prefix( $prefix, $n )
    order by $prefix ascending
    return <nsb pre="{$prefix}" ns="{$ns}"/>
    
    
    
    