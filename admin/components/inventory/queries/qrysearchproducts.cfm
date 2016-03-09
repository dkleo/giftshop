<cflock scope="Session" type="Readonly" timeout="10">
	<cfset TempVar.SearchQuery = '#Session.SearchQuery#'>
</cflock>

<cfquery name = "qrySearchproducts" Datasource = "#request.dsn#">
SELECT * 
FROM products
WHERE ProductID LIKE '%#TempVar.SearchQuery#%'  OR ProductName LIKE '%#TempVar.SearchQuery#%' 
</cfquery>




















