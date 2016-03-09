<cfquery name = "qryCountries" datasource="#request.dsn#">
SELECT *
FROM countries
</cfquery>

<cfquery name = "qryStates" datasource="#request.dsn#">
SELECT *
FROM states
</cfquery>















