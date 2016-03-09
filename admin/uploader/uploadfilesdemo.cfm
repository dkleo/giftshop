<!---NOTHING uploads in the demo
<cftry>
<!---This one uploads files for the filemanager--->
<cfparam name = "dir" default="docs#request.bslash#">

<CFFILE	Action="Upload"
FileField = "FileData"
Destination = "#request.catalogpath##dir#"
NameConflict = "overwrite">

<cfset thefile = cffile.serverfile>

<cfset thefile = replace(thefile, " ", "", "ALL")>
<cfset thefile = replace(thefile, "&", "", "ALL")>
<cfset thefile = replace(thefile, "_", "", "ALL")>
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

<cfset fullDespath = "#request.catalogpath##dir##request.bslash##thefile#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "\", "ALL")>

<cfset fullFrompath = "#request.catalogpath##dir#\#cffile.serverfile#">
<cfset fullFrompath = replacenocase(FullFromPath, "\\", "\", "ALL")>

<cfif NOT thefile IS cffile.serverfile>
	<cffile action = "rename"   
		source = "#fullfrompath#"   
		destination = "#fulldespath#">
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>--->



