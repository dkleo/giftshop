<!---uploads a file attachment for a product--->

<cftry>

<CFFILE	action="Upload"
FileField = "FileData"
Destination = "#request.downloadspath#"
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
<cfset thefile = lcase(thefile)>

<cfset fullDespath = "#request.catalogpath##dir##request.bslash##thefile#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath##dir##request.bslash##cffile.serverfile#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfif NOT thefile IS cffile.serverfile>
	<cffile action = "rename" source = "#fullfrompath#" destination = "#fulldespath#">
</cfif>
			
<cfset filename = "#thefile#">
<cfset filesize = "#cffile.FileSize#">

<cfquery name = "qryInsertFile" datasource="#request.dsn#">
INSERT INTO product_files
(filename, filesize, allowedDls, timesdownloaded, itemid)
VALUES
('#filename#','#filesize#',7,0,'#url.itemid#')
</cfquery>

<cfcatch>
	<cfinclude template = "../errorprocess.cfm">
    <cfabort>
</cfcatch>
</cftry>



