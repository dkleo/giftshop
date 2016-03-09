<!---Adds a shipping point to the list in the UPS, USPS, and FEDEX Settings Tables--->
<cfinclude template = "../queries/qryupssettings.cfm">

<cfoutput query = "qryUPSSettings">
<cfset TheCities = #ShipFromCities#>
<cfset TheStates = #ShipFromStates#>
<cfset TheCountries = #ShipFromCountries#>
<cfset TheZips = #ShipFromZips#>
</cfoutput>

<cfset NewCities = ListAppend(TheCities, form.City)>
<cfset NewStates = ListAppend(TheStates, form.Region)>
<cfset NewCountries = ListAppend(TheCountries, form.Country)>
<cfset NewZips = ListAppend(TheZips, form.ZipCode)>

<cfquery name = "AddShippingPoint" Datasource = "#request.dsn#">
UPDATE upsconfig
SET ShipFromStates = '#NewStates#',
ShipFromCities = '#NewCities#',
ShipFromCountries = '#NewCountries#',
ShipFromZips = '#NewZips#'
</cfquery>

<cfquery name = "AddShippingPoint" Datasource = "#request.dsn#">
UPDATE fedexconfig
SET ShipFromStates = '#NewStates#',
ShipFromCities = '#NewCities#',
ShipFromCountries = '#NewCountries#',
ShipFromZips = '#NewZips#'
</cfquery>

<cflocation url = "doshipping.cfm?action=SetShippingPoints">