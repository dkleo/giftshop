
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif isdefined('form.FolderName')>
	<cfset NewFolderName = replace(form.FolderName, "'", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, '"', '', 'ALL')>
	<cfset NewFolderName = replace(NewFolderName, "*", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, "&", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, "(", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, ")", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, ";", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, ":", "", "ALL")>
	<cfset NewFolderName = replace(NewFolderName, "!", "", "ALL")>
	
	<cfset fullpath = "#request.catalogpath##form.Dir##request.bslash##NewFolderName#">
	<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

	<cfoutput><cfdirectory action="create" directory="#fullpath#"></cfoutput>
</cfif>




















