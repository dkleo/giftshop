<cfquery name = "qryCategories" Datasource = "#request.dsn#">
SELECT * 
FROM categories
ORDER by CategoryName ASC
</cfquery>















