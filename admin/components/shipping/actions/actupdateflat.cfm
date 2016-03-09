<cfquery name = "UpdateCompanyInfo" Datasource = #request.dsn#>
UPDATE settings_main
SET InStateShipRate = '#Form.InstateShipRate#',
OutStateShipRate = '#Form.OutStateShipRate#'

</cfquery>

<cflocation url="doshipping.cfm">

