<cfset TheLinkTarget = form.LinkTarget>

<cfif form.LinkTarget IS 'None'>
	<cfset TheLinkTarget = ''>
</cfif>

<cfset Thumbnail = '#form.LinkImage#'>
<cfset Thumbnail2 = '#form.LinkRImage#'>

<cfif form.RemoveImage IS 'Yes'>
	<cfset Thumbnail = 'None'>
	<cfset Thumbnail2 = 'None'>
</cfif>

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
     	<cfset ThumbNail2 = 'none'>
     </cfif>
	</cfoutput>
</cfif>

<cfquery name="UpdateLink" Datasource="#request.dsn#">
UPDATE links
SET LinkOrder = '#form.LinkOrder#', 
LinkTitle = '#form.LinkTitle#', 
LinkRef = '#form.LinkRef#', 
LinkDescription = '#form.LinkDescription#', 
LinkTarget = '#TheLinkTarget#',
LinkImage = '#Thumbnail#',
LinkRImage = '#Thumbnail2#'
WHERE LinkID = #form.LinkID#
</cfquery>

<cflocation url = 'dolinks.cfm'>