<!---This script removes an item from the radio list--->
<cfoutput>
<CFSET NewoptionsList = ListDeleteAt(#session.OptionNames#, #url.ListItem#, "^")>
<CFSET Session.OptionNames = #NewoptionsList#>
<CFSET NewOptionPriceList = ListDeleteAt(#session.OptionPrices#, #url.ListItem#, "^")>
<CFSET Session.OptionPrices = #NewOptionPriceList#>
<CFSET NewOptionWeightList = ListDeleteAt(#session.OptionWeights#, #url.ListItem#, "^")>
<CFSET Session.OptionWeights = #NewOptionWeightList#>
</cfoutput>
<cfif ISDEFINED('url.itemid')>
	<cflocation url = "dooptions.cfm?action=AddRadioList&itemid=#url.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=AddRadioList">
</cfif>


