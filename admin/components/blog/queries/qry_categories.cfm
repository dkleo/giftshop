<cfquery name = "qry_Categories" datasource="#request.dsn#">
SELECT * FROM blog_category
ORDER BY blog_cat_name ASC
</cfquery>




















