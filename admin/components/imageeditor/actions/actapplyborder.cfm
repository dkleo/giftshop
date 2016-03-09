<cfset sourceImage = ImageRead('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>

<cfset ImageAddBorder(sourceImage, form.borderWidth, form.borderColor, form.borderType)>

<cfset oldimage = '#request.catalogpath#temp#request.bslash##cookie.imagefile#'>
<cfset newimage = "#request.Catalogpath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">

<cfcookie name = "imagefile" value="#replace(cookie.imagefile, lastcount, nextcount)#">
<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<cfset ImageWrite(sourceImage, '#newimage#')>

<cflocation url = "index.cfm">















