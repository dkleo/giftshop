<!---Move a drop down item up in the list--->

<cfif NOT isdefined('session.OptionNames')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset session.OptionNames="">
	<cfset session.OptionPrices= "">
	<cfset session.OptionWeights = "">
</cflock>
</cfif>

<!---if it's not in the top position then move it up one--->

<cfif NOT url.Position IS 1>

	<cfif ISDEFINED('session.OptionNames')>
		<cflock scope="session" type="ReadOnly" timeout="10">
			<cfset TempVar.OptionNames = Session.OptionNames>
			<cfset TempVar.OptionPrices = Session.OptionPrices>
			<cfset TempVar.OptionWeights = Session.OptionWeights>	
		</cflock>
	</cfif>
	
	<!---Get the items before this one--->
	<cfset beforepos = url.position - 1>
	<cfset beforeItem = listgetat(TempVar.OptionNames, beforepos, "^")>
	<cfset beforeItemPrice = listgetat(TempVar.OptionPrices, beforepos, "^")>
	<cfset beforeItemWeights = listgetat(TempVar.OptionWeights, beforepos, "^")>

	<cfset tomovepos = url.position>
	<cfset tomoveItem = listgetat(TempVar.OptionNames, tomovepos, "^")>
	<cfset tomoveItemPrice = listgetat(TempVar.OptionPrices, tomovepos, "^")>
	<cfset tomoveItemWeights = listgetat(TempVar.OptionWeights, tomovepos, "^")>
	
	<cfset NewOptionNames = ListSetAt(TempVar.OptionNames, beforepos, tomoveitem, "^")>
	<cfset NewOptionPrices = ListSetAt(TempVar.OptionPrices, beforepos, tomoveItemPrice, "^")>
	<cfset NewOptionWeights = ListSetAt(TempVar.OptionWeights, beforepos, tomoveItemWeights, "^")>
	
	<cfset NewOptionNames = ListSetAt(NewOptionNames, tomovepos, beforeitem, "^")>
	<cfset NewOptionPrices = ListSetAt(NewOptionPrices, tomovepos, beforeItemPrice, "^")>
	<cfset NewOptionWeights = ListSetAt(NewOptionWeights, tomovepos, beforeItemWeights, "^")>
	
	<cfset TempHolder.OptionNames = NewOptionNames>
	<cfset TempHolder.OptionPrices = NewOptionPrices>
	<cfset TempHolder.OptionWeights = NewOptionWeights>
	
	<cflock type="exclusive" scope="Session" timeout="10">
		<CFSET Session.OptionNames = #TempHolder.OptionNames#>
		<CFSET Session.OptionPrices = #TempHolder.OptionPrices#>
		<CFSET Session.OptionWeights = #TempHolder.OptionWeights#>
	</cflock>

</cfif>

<cfif isdefined('url.itemid')>
	<cflocation url = "dooptions.cfm?action=AddDropDown&itemid=#url.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=AddDropDown">
</cfif>



