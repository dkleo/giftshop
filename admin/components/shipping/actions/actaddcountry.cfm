<cfquery name = "AddCountry" datasource="#request.dsn#">
INSERT INTO countries
(Country, CountryCode, ShowThis)
VALUES
('#form.Country#', '#form.CountryCode#', 'Yes')
</cfquery>

<cflocation url = "doshipping.cfm?action=EditCountries">
