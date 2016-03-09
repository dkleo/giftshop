<!---Adds a shipping point to the list in the UPS Settings Table--->
<cfinclude template = "../queries/qryupssettings.cfm">

<cfoutput query = "qryUPSSettings">
<cfset TheCities = #ShipFromCities#>
<cfset TheStates = #ShipFromStates#>
<cfset TheCountries = #ShipFromCountries#>
<cfset TheZips = #ShipFromZips#>
</cfoutput>

<cfset NewCities= ListDeleteAt(TheCities, url.PointID)>
<cfset NewStates = ListDeleteAt(TheStates, url.PointID)>
<cfset NewCountries = ListDeleteAt(TheCountries, url.PointID)>
<cfset NewZips = ListDeleteAt(TheZips, url.PointID)>

<cfquery name = "DeleteUPSShippingPoint" Datasource = "#request.dsn#">
UPDATE upsconfig
SET ShipFromCities = '#NewCities#',
ShipFromStates = '#NewStates#',
ShipFromCountries = '#NewCountries#',
ShipFromZips = '#NewZips#'
</cfquery>

<cfquery name = "DeleteUPSShippingPoint" Datasource = "#request.dsn#">
UPDATE fedexconfig
SET ShipFromCities = '#NewCities#',
ShipFromStates = '#NewStates#',
ShipFromCountries = '#NewCountries#',
ShipFromZips = '#NewZips#'
</cfquery>

<cflocation url = "doshipping.cfm?action=SetShippingPoints">
