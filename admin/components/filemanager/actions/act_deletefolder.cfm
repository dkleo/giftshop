<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<!---Deletes a folder and everything in it--->
<cfset fullpath = "#request.catalogpath##url.Dir##request.bslash##url.FolderName#">
<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfoutput><cfdirectory action="delete" directory="#fullpath#" recurse="yes"></cfoutput>



















