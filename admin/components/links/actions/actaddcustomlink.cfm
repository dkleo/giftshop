<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif form.FileLink IS 'None'>

	<cfif form.linkTarget IS 'Same'>
        <cfset TheTarget = ''>
    </cfif>
    <cfif form.linkTarget IS 'New'>
        <cfset TheTarget = '_blank'>
    </cfif>
    <cfif form.linkTarget IS 'Frame'>
        <cfset TheTarget = 'iFrame'>
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

	<cfif NOT LinkRef is '' AND NOT form.LinkRef IS 'http://'>
        <cfquery name = "AddLink" datasource="#request.dsn#">
        INSERT INTO links
        (LinkOrder, LinkTitle, LinkRef, LinkDescription, LinkTarget, LinkImage, LinkRImage, urlrw)
        VALUES
        ('#form.LinkOrder#', '#form.LinkTitle#', '#form.LinkRef#', '#form.LinkDescription#', '#TheTarget#', '#Thumbnail#', '#Thumbnail2#', 'NONE')
        </cfquery>
    </cfif>
</cfif>

<!---Now if they choose a file from the drop down box (if available) then make the link docs/thefilechosen.
If they choose to have it load in the template then reference the index.cfm file and assign the content to
the page URL variable--->

<cfif NOT form.FileLink IS 'None'>

<cfif form.LinkTarget IS 'Same'>
	<cfset TheTarget = ''>
	<cfset TheLinkRef = '#request.HomeURL#/docs/#form.FileLink#'>
</cfif>
<cfif form.LinkTarget IS 'New'>
	<cfset TheTarget = '_blank'>
	<cfset TheLinkRef = '#request.HomeURL#/docs/#form.FileLink#'>
</cfif>
<cfif form.LinkTarget IS 'InTemplate'>
	<cfset TheTarget = ''>
	<cfset TheLinkRef = '#request.HomeURL#/index.cfm?Page=docs/#form.FileLink#'>
</cfif>

<cfquery name = "AddLink" datasource="#request.dsn#">
INSERT INTO links
(LinkOrder, LinkTitle, LinkRef, LinkDescription, LinkTarget, LinkImage, LinkRImage, urlrw)
VALUES
('#form.LinkOrder#', '#form.LinkTitle#', '#TheLinkRef#', '#form.LinkDescription#', '#TheTarget#', '#Thumbnail#', '#Thumbnail2#', 'NONE')
</cfquery>
</cfif>

<cflocation url = "dolinks.cfm">