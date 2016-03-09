<!---Uploads an image to the image library and creates a thumbnail for it.--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfinclude template = "../queries/qrycompanyinfo.cfm">

<!---Upload the image--->

<CFFILE	Action="Upload"
FileField = "form.ImageFile"
Destination = "#request.CatalogPath#images#request.bslash#"
NameConflict = "overwrite"
Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png"
mode="777">

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

<cfset fullDespath = "#request.catalogpath#images#request.bslash##thefile#">
<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullFrompath = "#request.catalogpath#images#request.bslash##cffile.serverfile#">
<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfoutput>#fullfrompath#</cfoutput><br />
<cfoutput>#fulldespath#</cfoutput>

<cfif NOT thefile IS cffile.serverfile>
	<cffile action = "rename"   
		source = "#fullfrompath#"   
		destination = "#fulldespath#">
</cfif>
			
<cfset photo = "#thefile#">
<cfset thumb = "#thefile#">

<cfinclude template = "actProcessImage.cfm">

<cfif NOT isdefined('url.wasdoing')>
	<cflocation url = "doimagelibrary.cfm?dir=#form.dir#">
<cfelse>
	<cflocation url = "doimagelibrary.cfm?action=browse&dir=#form.dir#&ffield=#url.ffield#&fname=#url.fname#">
</cfif>



















