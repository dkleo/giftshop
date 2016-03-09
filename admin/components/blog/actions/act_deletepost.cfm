<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qry_DeletePost" datasource="#request.dsn#">
DELETE FROM blog_posts
WHERE blog_id = '#url.blog_id#'
</cfquery>

<!---Remove all replies to this post--->
<cfquery name = "qry_DeleteReplies" datasource="#request.dsn#">
DELETE FROM blog_reply
WHERE reply_blog_id = '#url.blog_id#'
</cfquery>

<cflocation url = "index.cfm?action=blog.edit.default&mytoken=#mytoken#&m=#url.m#&y=#url.y#">




















