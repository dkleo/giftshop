<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfset fullpath = "#request.catalogpath##url.Dir##request.bslash##url.Filename#">
<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfif fileexists('#fullpath#')>
<cfoutput><cffile action="Delete" file="#fullpath#"></cfoutput>
</cfif>



















