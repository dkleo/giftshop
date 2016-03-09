<cfset sourceImage = ImageRead('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>

<cfparam name="backgroundColor" default="white" type="regex" pattern="[A-Za-z0-9##]+">
<cfparam name="mirrorHeight" default="120">
<cfparam name="startOpacity" default="30">

<cfinvoke component="CFImageEffects" method="init" returnvariable="effects">

<cfset reflectedImage = effects.applyReflectionEffect(sourceImage, backgroundColor, mirrorHeight, startOpacity)>

<cfset oldimage = '#request.catalogpath#temp#request.bslash##cookie.imagefile#'>
<cfset newimage = "#request.Catalogpath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">

<cfcookie name = "imagefile" value="#replace(cookie.imagefile, lastcount, nextcount)#">
<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<cfset ImageWrite(reflectedImage, '#newimage#')>

<cflocation url = "index.cfm">















