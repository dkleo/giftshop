<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfset linkuuid = #CreateUUID()#>

<cfif NOT form.blog_link_name IS ''>
<cfquery name = "qry_InserLink" datasource="#request.dsn#">
INSERT INTO blog_links
(blog_link_id, blog_link_name, blog_link_url)
VALUES
('#linkuuid#', '#form.blog_link_name#', '#form.blog_link_url#')
</cfquery>
</cfif>

<cflocation url = "index.cfm?action=blog.links.default&mytoken=#mytoken#&isplugin=yes">



















