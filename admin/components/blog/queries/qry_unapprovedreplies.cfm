<cfquery name = "qry_UAreplies" datasource="#request.dsn#">
SELECT * FROM blog_reply
WHERE approved = 0 AND reply_blog_id = '#blog_id#'
</cfquery>





















