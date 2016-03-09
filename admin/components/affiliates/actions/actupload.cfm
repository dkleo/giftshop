<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT directoryexists('#request.catalogpath#images#request.bslash#banners')>
	<cfdirectory action="create" directory="#request.catalogpath#images#request.bslash#banners" mode="777">
</cfif>

<cfif len(trim(form.imagefile)) IS 0>
	You must specify an image file to upload from your computer.
    <cfabort>
</cfif>

<CFFILE Action="Upload"
FileField = "Form.ImageFile"
Destination = "#request.catalogpath#images#request.bslash#banners#request.bslash#"
NameConflict="makeunique"
mode="777">

<cfif NOT cffile.serverfile CONTAINS '.gif' AND NOT cffile.serverfile CONTAINS '.jpg' AND NOT cffile.serverfile CONTAINS '.jpeg' AND NOT cffile.serverfile CONTAINS '.png'>
	<cfoutput>The image file you specified is not a valid web image format.  Please upload a .JPG, .GIF, or .PNG image file. The file type you uploaded was "#right(cffile.serverfile, 4)#"</cfoutput>
    <cffile action = "delete" file="#request.catalogpath#images#request.bslash#banners#request.bslash##cffile.serverfile#">    
    <cfabort>
</cfif>

<!---Read the banner and find out the size--->
<cfset photo = cffile.serverfile>

<cfinclude template = "actreadimage.cfm">

<cfquery name="InsertImage" datasource = "#request.dsn#">
INSERT INTO afl_banners
(location, height, width, descr)
VALUES
('#CFFILE.ServerFile#', '#iHeight#', '#iWidth#', '')
</cfquery>

<cflocation url = "index.cfm?action=banners">











