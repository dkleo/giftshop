<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qry_UpDeleteCategory" datasource="#request.dsn#">
DELETE FROM blog_category
WHERE blog_cat_id = '#url.blog_cat_id#'
</cfquery>

<cflocation url = "index.cfm?action=blog.categories.default&mytoken=#mytoken#&isplugin=yes">



















