<cfquery name = "qryMfgs" datasource="#request.dsn#">
SELECT DISTINCT mfg
FROM products
ORDER BY mfg ASC
</cfquery>















