<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset catuuid = #CreateUUID()#>

<cfif NOT form.blog_cat_name IS ''>
<cfquery name = "qry_InserCategory" datasource="#request.dsn#">
INSERT INTO blog_category
(blog_cat_id, blog_cat_name)
VALUES
('#catuuid#', '#form.blog_cat_name#')
</cfquery>
</cfif>

<cflocation url = "index.cfm?action=blog.categories.default&mytoken=#mytoken#&isplugin=yes">



















