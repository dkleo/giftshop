<cfset sourceImage = ImageRead('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>

<cfinvoke component="CFImageEffects" method="init" returnvariable="effects">

<cfset sepiaimage = effects.sepiaTone(sourceImage)>

<cfset oldimage = '#request.catalogpath#temp#request.bslash##cookie.imagefile#'>
<cfset newimage = "#request.Catalogpath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">

<cfcookie name = "imagefile" value="#replace(cookie.imagefile, lastcount, nextcount)#">
<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<cfset ImageWrite(sepiaImage, '#newimage#')>

<cflocation url = "index.cfm">















