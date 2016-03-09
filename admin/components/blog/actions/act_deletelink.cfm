<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qry_UpDeleteLink" datasource="#request.dsn#">
DELETE FROM blog_links
WHERE blog_link_id = '#url.blog_link_id#'
</cfquery>

<cflocation url = "index.cfm?action=blog.links.default&mytoken=#mytoken#&isplugin=yes">



















