<cfquery name = "qry_Links" datasource="#request.dsn#">
SELECT * FROM blog_links
ORDER BY blog_link_name ASC
</cfquery>




















