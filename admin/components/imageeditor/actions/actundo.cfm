<cfset prev_step = cookie.current_step - 1>
<cfset r_prev_step = '#prev_step#_'>
<cfset r_current_step = '#cookie.current_step#_'>

<cfif prev_step GT 0>
	<!---delete current viewed image--->
    <cffile action="delete" file="#request.catalogpath#temp#request.bslash##cookie.imagefile#">
    <cfcookie name = "imagefile" value="#replace(cookie.imagefile, r_current_step, r_prev_step)#">
    <cfcookie name = "current_step" value="#prev_step#">
</cfif>
<cflocation url = "index.cfm">















