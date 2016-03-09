<cfquery name = "qry_PostReplies" datasource="#request.dsn#">
SELECT * FROM blog_reply
WHERE reply_blog_id = '#blog_id#'
</cfquery>





















