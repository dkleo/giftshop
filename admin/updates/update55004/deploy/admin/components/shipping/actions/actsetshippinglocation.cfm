<cfquery name = "SetDefaultShippingPoint" Datasource = "#request.dsn#">
UPDATE upsconfig
SET ShipFromStates = '#form.state#',
ShipFromCities = '#form.city#',
ShipFromCountries = '#form.country#',
ShipFromZips = '#form.zip#'
</cfquery>

<cfquery name = "SetDefaultShippingPoint" Datasource = "#request.dsn#">
UPDATE fedexconfig
SET ShipFromStates = '#form.state#',
ShipFromCities = '#form.city#',
ShipFromCountries = '#form.country#',
ShipFromZips = '#form.zip#'
</cfquery>

Shipping settings have been saved.