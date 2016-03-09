<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT form.blog_cat_name IS ''>
	<cfquery name = "qry_Updatecategory" datasource="#request.dsn#">
	UPDATE blog_category
	SET blog_cat_name = '#form.blog_cat_name#'
	WHERE blog_cat_id = '#form.blog_cat_id#'
	</cfquery>
</cfif>
<cflocation url = "index.cfm?action=blog.categories.default&mytoken=#mytoken#&isplugin=yes">



















