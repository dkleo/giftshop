<cfif NOT isDEFINED('form.choicebox')>
ERROR:  You have to at least select ONE Country you will ship to!!!
<cfabort>
</cfif>

<cfinclude template = "../queries/qrycountries.cfm">

<cfif NOT ISDEFINED('form.ChoiceBox')>
ERROR:  You have to at least select ONE country!
<cfabort>
</cfif>

<cfset MyCountryList = ''>
<cfoutput query = "qryCountries">
<cfset CountryMasterList = #Countries#>
</cfoutput>

<cfloop index = "MyCount" From="1" To="#ListLen(form.choiceBox)#">
<cfset ThisCountryCode = #ListGetAt(form.choiceBox, mycount)#>
<cfloop index = "mycount2" From="1" to="#ListLen(qryCountries.CountryCodes)#">
	<cfset CountryCodeSelect = #ListGetAt(qryCountries.CountryCodes, mycount2)#>
	<cfif CountryCodeSelect IS ThisCountryCode>
	<Cfset ActualCountryName = #ListGetAt(qryCountries.Countries, mycount2)#>
	<cfset MyCountryList = #MyCountryList# & "," & #ActualCountryName#>
	</cfif>
</cfloop>
</cfloop>

<cfquery name = "UpdateCountries" datasource="#request.dsn#">
UPDATE sellingareas
SET SelectedCountries = '#MyCountryList#',
SelectedCCodes = '#Form.ChoiceBox#'

</cfquery>
<cflocation url = "doshipping.cfm?action=ShippingAreas">
