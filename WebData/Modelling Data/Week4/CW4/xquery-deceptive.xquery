xquery version "1.0";
declare namespace bjp = 'http://ex.org';

(: get prefix and uri of namespace within a node :)
declare function bjp:nsBindingForNode($node)
{
    for $n in $node
    for $prefix in fn:in-scope-prefixes( $n )
    for $ns in fn:namespace-uri-for-prefix( $prefix, $n )
    order by $prefix ascending
    return <nsb pre="{$prefix}" ns="{$ns}"/>
};
(: same prefix with different URI in different scope :)
declare function bjp:multiURI($nsb)
{  
    for $b1 in $nsb
    for $b2 in $nsb
    where ($b1/@pre = $b2/@pre) and not( $b1/@ns = $b2/@ns)
    return <multi>{$b1} {$b2}</multi>
};
(:test deceptive:)
declare function bjp:isDeceptive($d)
{
    for $m in bjp:multiURI( bjp:nsBindingForNode($d) )
    return 'YES - it is deceptive!'
};

fn:distinct-values( bjp:isDeceptive(//*) )