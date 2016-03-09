<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfloop from = "1" to = "#listlen(page_names)#" index="p">
	<cfset thisfilename = listgetat(page_names, p)>
	<cfset thissub = listgetat(permissions, p)>    

    <cfquery name = "qryDeleteOldPermissions" datasource="#request.dsn#">
    DELETE FROM private_pages
    WHERE page_filename = '#thisfilename#'
    </cfquery>
    
    <cfquery name = "qryUpdatePermissions" datasource="#request.dsn#">
    INSERT INTO private_pages
    (subscription_id,  page_filename)
    VALUES
    ('#thissub#', '#thisfilename#')
	</cfquery>
    
</cfloop>
   
<cflocation url = "dopages.cfm?wasupdate=yes">















