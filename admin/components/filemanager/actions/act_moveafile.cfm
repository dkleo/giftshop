<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "Dir" default="#request.bslash#">

<cfset fullDespath = "#request.catalogpath##Dir#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath##url.filetomove#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>


<cfoutput>
<cffile action="move" source="#fullFrompath#" destination="#fullDespath#">
</cfoutput>




















