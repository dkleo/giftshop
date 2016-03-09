<cfquery name = "qry_Posts" datasource="#request.dsn#">
SELECT * FROM blog_posts
WHERE blog_year = #y# AND blog_month = #m#
</cfquery>




















