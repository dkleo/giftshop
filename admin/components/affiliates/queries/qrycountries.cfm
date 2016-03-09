<cfquery name = "qryCountries" datasource="#request.dsn#">
SELECT * FROM countries WHERE showthis ='yes'
ORDER BY country ASC
</cfquery>











