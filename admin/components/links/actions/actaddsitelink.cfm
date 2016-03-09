<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif len(form.LinkTitle) IS 0>
	You need to give the link a title!
	<cfabort>
</cfif>

<cfif filelink IS 'NONE'>
	You need to select a page or component to link to!
    <cfabort>
</cfif>

<cfset PageFile = form.FileLink>
<cfset PageTitle = form.LinkTitle>

<cfif form.LinkTarget IS 'Same'>
	<cfset TheTarget = ''>
	<cfset TheLinkRef = '#form.FileLink#'>
</cfif>
<cfif form.LinkTarget IS 'New'>
	<cfset TheTarget = '_blank'>
	<cfset TheLinkRef = '#form.FileLink#'>
</cfif>
<cfif form.LinkTarget IS 'InTemplate'>
	<cfset TheTarget = ''>
	<cfset TheLinkRef = '#form.FileLink#'>
</cfif>

<cfset Thumbnail = 'None'>
<cfset Thumbnail2 = 'None'>

<cfif NOT form.filecontents IS ''>
	<cfoutput>
	<CFFILE Action="Upload"
				FileField = "Form.filecontents"
				Destination = "#request.CatalogPath#photos#request.bslash#"
				NameConflict = "overwrite"
				Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg">
			
		<cfset ThumbNail = #cffile.ServerFile#>
	
	<cfif NOT form.filecontents2 IS ''>
    <CFFILE Action="Upload"
				FileField = "Form.filecontents2"
				Destination = "#request.CatalogPath#photos#request.bslash#"
				NameConflict = "overwrite"
				Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg">
			
		<cfset ThumbNail2 = #cffile.ServerFile#>
        
     <cfelse>
     	<cfset ThumbNail2 = 'None'>
     </cfif>
	</cfoutput>
</cfif>

<cfif form.widgetsleft IS 'hide'>
	<cfset thelinkref = '#TheLinkRef#&hwl=t'>
</cfif>           	
<cfif form.widgetsright IS 'hide'>
	<cfset thelinkref = '#TheLinkRef#&hwr=t'>
</cfif>

<cfset linkalias = Pagetitle>
<cfset linkalias = replace(linkalias, " ", "-", "ALL")>
<cfset linkalias = replace(linkalias, "'", "", "ALL")>
<cfset linkalias = replace(linkalias, "!", "", "ALL")>
<cfset linkalias = replace(linkalias, "@", "", "ALL")>
<cfset linkalias = replace(linkalias, "$", "", "ALL")>
<cfset linkalias = replace(linkalias, "%", "", "ALL")>
<cfset linkalias = replace(linkalias, "^", "", "ALL")>
<cfset linkalias = replace(linkalias, "*", "", "ALL")>
<cfset linkalias = replace(linkalias, "(", "", "ALL")>	
<cfset linkalias = replace(linkalias, ")", "", "ALL")>
<cfset linkalias = replace(linkalias, "/", "", "ALL")>	
<cfset linkalias = replace(linkalias, "\", "", "ALL")>
<cfset linkalias = replace(linkalias, "|", "", "ALL")>
<cfset linkalias = replace(linkalias, "<", "", "ALL")>   	
<cfset linkalias = replace(linkalias, ">", "", "ALL")>    
<cfset linkalias = replace(linkalias, ";", "", "ALL")>
<cfset linkalias = replace(linkalias, ":", "", "ALL")>
<cfset linkalias = replace(linkalias, '"', "", "ALL")>
<cfset linkalias = replace(linkalias, ".", "", "ALL")>	
<cfset linkalias = replace(linkalias, ",", "", "ALL")> 

<cfquery name = "AddLink" datasource="#request.dsn#">
INSERT INTO links
(LinkOrder, LinkTitle, LinkRef, LinkDescription, LinkTarget, LinkImage, LinkRImage, urlrw)
VALUES
('#form.LinkOrder#', '#PageTitle#', '#TheLinkRef#', '#form.LinkDescription#', '#TheTarget#', '#Thumbnail#', '#Thumbnail2#', '#linkalias#')
</cfquery>

<!---write to htaccess for url rewrites--->
<cffile action = "append" output="ReWriteRule ^#linkalias#$ #TheLinkRef# " file="#request.catalogpath#.htaccess" addnewline="yes">

<cflocation url = "dolinks.cfm">