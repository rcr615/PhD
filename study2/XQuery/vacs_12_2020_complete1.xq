for $node in db:open("WS-U-T-B_merge")//node[@rel="hd"]
  where $node[@lcat="smain" or @lcat="ssub" or @lcat="inf" or @lcat="ppart" or @lcat="sv1"] and $node[not(ancestor::*[@cat="ti"])]
  let $word := 
                if ($node[@sc="passive"]) then
                  $node/../node[@rel="vc"]/node[@rel="hd"]/@root
                else
                  $node/@root
  let $sc := $node/@sc
  let $sentid := $node/ancestor::node/../sentence/[@sentid]
  let $siblings := $node/../node/@word
  let $presibs := $node/preceding-sibling::node
  let $presibsid := $presibs/@id
  let $postsibs:= $node/following-sibling::node
   let $sorted := for $node in $presibs | $postsibs | $node
                    order by $node/begin
                    return $node/@rel
   return string-join(($sorted, string-join(($word, "verb"), ":"), string-join(($sc, "sc"),":"), string-join(($sentid, "sentid"), ":")), "|")