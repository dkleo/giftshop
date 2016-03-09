<cfquery name = "qryCustomers" datasource="#request.dsn#">
SELECT * FROM customerhistory
<cfif NOT searchstring IS 'null'>
WHERE lastname LIKE '%#searchstring#%' 
OR firstname LIKE '%#searchstring#%' 
OR customerid LIKE '%#searchstring#%'
</cfif>
ORDER BY lastname ASC
</cfquery>
















