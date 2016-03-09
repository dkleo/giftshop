<cfset sourceImage = ImageRead('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>

<cfparam name="backgroundColor" default="white" type="regex" pattern="[A-Za-z0-9##]+">	
<cfparam name="shadowcolor" default="gray" type="regex" pattern="[A-Za-z0-9##]+">
<cfparam name="shadowwidth" default="3">
<cfparam name="shadowDistance" default="4">

<cfset backgroundcolor = replace(backgroundcolor, "##", "")>
<cfset shadowcolor = replace(shadowcolor, "##", "")>

<cfinvoke component="CFImageEffects" method="init" returnvariable="effects">

<cfset reflectedImage = effects.applyDropShadowEffect(sourceImage, backgroundcolor, shadowColor, shadowWidth, shadowDistance)>

<cfset oldimage = '#request.catalogpath#temp#request.bslash##cookie.imagefile#'>
<cfset newimage = "#request.Catalogpath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">

<cfcookie name = "imagefile" value="#replace(cookie.imagefile, lastcount, nextcount)#">

<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<!---Write Image to Temp Folder---> 
<cfset ImageWrite(reflectedImage, '#newimage#')>

<cflocation url = "index.cfm">
















