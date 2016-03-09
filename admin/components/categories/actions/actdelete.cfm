<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Delete all subcategories under this category--->
<cfquery name = "DeleteCategory" datasource="#request.dsn#">
DELETE FROM categories
WHERE CategoryPath LIKE '%/#url.categoryid#/%'
</cfquery>

<cfquery name = "DeleteCategory" datasource="#request.dsn#">
DELETE FROM categories
WHERE CategoryID = #url.categoryid#
</cfquery>

<cfif fileexists('#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#url.categoryid#.cfm')>
	<cffile action = "delete" file = "#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#url.categoryid#.cfm">
</cfif>

<cflocation URL = "index.cfm">





















