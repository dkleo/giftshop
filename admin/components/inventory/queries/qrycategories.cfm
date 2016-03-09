<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM categories
ORDER BY categoryName ASC
</cfquery>



















