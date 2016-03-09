<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfparam name = "Dir" default="#request.bslash#">

<cfset fullDespath = "#request.catalogpath##Dir##request.bslash#Copy of #url.filetocopy#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath##url.copyfrom##request.bslash##url.filetocopy#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>


<cfoutput>
<cffile action="copy" source="#fullFrompath#" destination="#fullDespath#" nameconflict="makeunique">
</cfoutput>




















