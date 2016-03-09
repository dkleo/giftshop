<cfquery name = "qryAvailability" datasource="#request.dsn#">
SELECT DISTINCT availability
FROM products
ORDER BY availability ASC
</cfquery>















