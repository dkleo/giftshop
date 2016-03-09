<cfquery name = "qryBrands" datasource="#request.dsn#">
SELECT DISTINCT brand
FROM products
ORDER BY brand ASC
</cfquery>















