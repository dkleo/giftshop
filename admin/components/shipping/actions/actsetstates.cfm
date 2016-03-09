<cfinclude template = "../queries/qrystates.cfm">

<cfset MyStateList = ''>
<cfset MyChoices = ''>

<cfoutput query = "qryStates">
<cfset StateMasterList = #States#>
<cfif ISDEFINED('form.choicebox')>
<cfset MyChoices = '#form.ChoiceBox#'>
<cfloop index = "MyCount" From="1" To="#ListLen(form.choiceBox)#">
<cfset ThisStateCode = #ListGetAt(form.choiceBox, mycount)#>
<cfloop index = "mycount2" From="1" to="#ListLen(StateCodes)#">
	<cfset StateCodeSelect = #ListGetAt(StateCodes, mycount2)#>
	<cfif StateCodeSelect IS ThisStateCode>
	<Cfset ActualStateName = #ListGetAt(States, mycount2)#>
	<cfset MyStateList = #MyStateList# & "," & #ActualStateName#>
	</cfif>
</cfloop>
</cfloop>
</cfif>
</cfoutput>

<cfquery name = "UpdateStates" datasource="#request.dsn#">
UPDATE sellingareas
SET SelectedStates = '#MyStateList#',
SelectedSCodes = '#MyChoices#'

</cfquery>
<cflocation url = "doshipping.cfm?action=ShippingAreas">

