<cfquery name = "DeleteCountry" datasource="#request.dsn#">
DELETE FROM countries
WHERE ID = #url.CountryID#
</cfquery>

<cflocation url = "doshipping.cfm?action=editcountries">
