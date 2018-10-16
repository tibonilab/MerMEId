import module namespace login="http://kb.dk/this/login" at "./login.xqm";

declare namespace functx = "http://www.functx.com";
declare namespace m="http://www.music-encoding.org/ns/mei";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace uuid="java:java.util.UUID";

declare option    exist:serialize "method=xml media-type=text/html"; 

declare variable $dcmroot := "/db/dcm/";

let $return_to := concat("http://",request:get-header('HOST'),"/storage/list_files.xq?")


let $log-in := login:function()
let $res := response:redirect-to($return_to cast as xs:anyURI) 
let $parameters :=  request:get-parameter-names()

return
<p>
  {
    for $parameter in $parameters 
    let $resource := concat($dcmroot,$parameter)
    where request:get-parameter($parameter,"")="delete" and contains($parameter,"xml")
    return xdb:remove( $dcmroot, $resource)
  }
</p>


