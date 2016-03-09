<cfquery name = "qry_Post" datasource="#request.dsn#">
SELECT * FROM blog_posts
WHERE blog_id = '#blog_id#'
</cfquery>




















