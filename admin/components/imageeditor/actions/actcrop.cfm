<!---crops the image--->
<cfset cimage = imageread('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>
<cfset ImageCrop(cimage,form.x1,form.y1,form.width,form.height)>

<cfset oldimage = '#request.catalogpath#temp#request.bslash##cookie.imagefile#'>
<cfset newimage = "#request.Catalogpath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">

<cfcookie name = "imagefile" value="#replace(cookie.imagefile, lastcount, nextcount)#">

<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<!---Write Image to Temp Folder---> 
<cfset ImageWrite(cimage, '#newimage#')>

<!---right image to temp--->
<!---<cfimage source="#cimage#" action="write" destination="#request.catalogpath#temp#request.bslash##nextcount#_#cookie.imagefile#" overwrite="yes">--->

<!---reset cookie to new file name--->
<!---<cfcookie name="imagefile" value="#newtemp_name#">--->
<!---<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">--->

<cflocation url = "index.cfm">















