<!---This script removes an item from the drop down box--->
<cfoutput>
<CFSET NewoptionsList = ListDeleteAt(#session.OptionNames#, #url.ListItem#, "^")>
<CFSET Session.OptionNames = #NewoptionsList#>
<CFSET NewOptionPriceList = ListDeleteAt(#session.OptionPrices#, #url.ListItem#, "^")>
<CFSET Session.OptionPrices = #NewOptionPriceList#>
<CFSET NewOptionWeightList = ListDeleteAt(#session.OptionWeights#, #url.ListItem#, "^")>
<CFSET Session.OptionWeights = #NewOptionWeightList#>
</cfoutput>
<cfif ISDEFINED('url.itemid')>
	<cflocation url = "dooptions.cfm?action=AddDropDown&itemid=#url.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=AddDropDown">
</cfif>


