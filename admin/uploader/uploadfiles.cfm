<cftry>

<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---This one uploads files for the filemanager--->
<cfparam name = "dir" default="docs#request.bslash#">

<CFFILE	Action="Upload"
FileField = "FileData"
Destination = "#request.catalogpath##dir#"
NameConflict = "overwrite"
mode="777">

<cfset thefile = cffile.serverfile>

<cfset thefile = replace(thefile, " ", "_", "ALL")>
<cfset thefile = replace(thefile, "&", "", "ALL")>
<cfset thefile = replace(thefile, "(", "", "ALL")>
<cfset thefile = replace(thefile, ")", "", "ALL")>
<cfset thefile = replace(thefile, "?", "", "ALL")>
<cfset thefile = replace(thefile, "<", "", "ALL")>
<cfset thefile = replace(thefile, ">", "", "ALL")>
<cfset thefile = replace(thefile, "@", "", "ALL")>
<cfset thefile = replace(thefile, "!", "", "ALL")>
<cfset thefile = replace(thefile, "*", "", "ALL")>
<cfset thefile = replace(thefile, "^", "", "ALL")>
<cfset thefile = replace(thefile, "%", "", "ALL")>
<cfset thefile = replace(thefile, "$", "", "ALL")>
<cfset thefile = lcase(thefile)>

<cfset fullDespath = "#request.catalogpath##dir##request.bslash##thefile#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath##dir##request.bslash##cffile.serverfile#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfif NOT thefile IS cffile.serverfile>
	<cffile action = "rename" source = "#fullfrompath#" destination = "#fulldespath#" mode="777">
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>



