<!---ERROR CHECK--->

<cfif NOT isdefined('session.OptionNames')>
<cflock scope="session" type="exclusive" timeout="10">
	<cfset session.OptionNames="">
	<cfset session.OptionPrices= "">
	<cfset session.OptionWeights = "">
	<cfset session.OptionItemIDs = "">
</cflock>
</cfif>

<cfif ISDEFINED('session.OptionNames')>
	<cflock scope="session" type="ReadOnly" timeout="10">
		<cfset TempVar.OptionNames = Session.OptionNames>
		<cfset TempVar.OptionPrices = Session.OptionPrices>
		<cfset TempVar.OptionWeights = Session.OptionWeights>	
        <cfset TempVar.OptionItemIDs = Session.OptionItemIDs>
	</cflock>
</cfif>

<cfset TempHolder.OptionNames = "">
<cfset TempHolder.OptionPrices = "">
<cfset TempHolder.OptionWeights = "">
<cfset TempHolder.OptionItemIDs = "">

<!---Update the entries first--->
<cfloop index="MyCount" FROM="1" TO="#ListLen(TempVar.OptionNames, '^')#">
	<cfset ItemFormName = "Form.Items" & #MyCount#>
	<cfset ItemFormPrice = "Form.Prices" & #MyCount#>
	<cfset ItemFormWeight = "Form.Weights" & #MyCount#>	
    <cfset ItemFormItemID = "Form.ItemIDs" & #MyCount#>
	
    <cfif len(trim(evaluate(ItemFormItemID))) IS 0>
    	<cfset ItemFormItemID = '0'>
    </cfif>

	<cfif Evaluate(ItemFormName) IS ''>
		<cfset ErrorMessage = "You didn't fill in a caption for this item.  Nothing was updated."> 
		<cfset ErrorLine = #MyCount#>
		<cfif ISDEFINED('form.itemid')>
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#&itemid=#form.itemid#">
		<cfelse>		
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#">
		</cfif>
	</cfif>
	<cfif Evaluate(ItemFormPrice) IS ''>
		<cfset ErrorMessage = "You must specify a Price for each list item.  Enter 0.00 if no price. Nothing was updated."> 
		<cfset ErrorLine = #MyCount#>
		<cfif ISDEFINED('form.itemid')>
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#&itemid=#form.itemid#">
		<cfelse>		
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#">
		</cfif>

	</cfif>
	<cfif Evaluate(ItemFormWeight) IS ''>
		<cfset ErrorMessage = "Error: You must specify a Weight for each item.  Enter 0.00 if no weight. Nothing was updated."> 
		<cfset ErrorLine = #MyCount#>
		<cfif ISDEFINED('form.itemid')>
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#&itemid=#form.itemid#">
		<cfelse>		
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#">
		</cfif>

	</cfif>
	<cfif NOT Isnumeric(Evaluate(ItemFormPrice))>
		<cfset ErrorMessage = "All prices must be numeric!  Do NOT enter a symbol! Nothing was updated."> 
		<cfset ErrorLine = #MyCount#>
		<cfif ISDEFINED('form.itemid')>
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#&itemid=#form.itemid#">
		<cfelse>		
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#">
		</cfif>

	</cfif>
	<cfif NOT Isnumeric(Evaluate(ItemFormWeight))>
		<cfset ErrorMessage = "All Weights must be numeric!  Do NOT enter a symbol! Nothing was updated."> 
		<cfset ErrorLine = #MyCount#>
		<cfif ISDEFINED('form.itemid')>
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#&itemid=#form.itemid#">
		<cfelse>		
			<cflocation url = "dooptions.cfm?Action=AddRadioList&EditErrorLine=#ErrorLine#&EditErrorMessage=#ErrorMessage#">
		</cfif>

	</cfif>

<CFSET NewoptionsList = ListAppend(#TempHolder.OptionNames#, #Evaluate(ItemFormName)#, "^")>
<CFSET NewOptionPriceList = ListAppend(#TempHolder.OptionPrices#, #Evaluate(ItemFormPrice)#, "^")>
<CFSET NewOptionWeightList = ListAppend(#TempHolder.OptionWeights#, #Evaluate(ItemFormWeight)#, "^")>
<CFSET NewoptionsItemIDList = ListAppend(#TempHolder.OptionItemIDs#, #Evaluate(ItemFormItemID)#, "^")>

<cfset TempHolder.OptionNames = NewoptionsList>
<cfset TempHolder.OptionPrices = NewOptionPriceList>
<cfset TempHolder.OptionWeights = NewOptionWeightList>
<cfset TempHolder.OptionItemIDs = NewoptionsItemIDList>
</cfloop>

<!---ADDED 04-27-2007 BY JON...DELETES ITEMS USING FORM FIELD INSTEAD OF ONE AT A TIME WITH THE LINK--->
<!---Now remove any if they wanted some removed--->
<cfif isdefined('form.removeoptions')>

<cfset NewoptionsList = TempHolder.OptionNames >
<cfset NewOptionPriceList = TempHolder.OptionPrices>
<cfset NewOptionWeightList = TempHolder.OptionWeights>
<cfset NewoptionsItemIDList = TempHolder.OptionItemIDs >

	<cfloop from = "#ListLen(form.removeoptions)#" to = "1" step="-1" index="oCount">
	<cfset thisPos = listgetat(form.removeoptions, oCount)>
		<CFSET NewoptionsList = #ListDeleteAt(NewOptionsList, thisPos, "^")#>
		<CFSET NewOptionPriceList = #ListDeleteAt(NewOptionPriceList, thisPos, "^")#>
		<CFSET NewOptionWeightList = #ListDeleteAt(NewOptionWeightList, thisPos, "^")#>
        <CFSET NewoptionsItemIDList = #ListDeleteAt(NewOptionsItemIDList, thisPos, "^")#>
	</cfloop>

<cfset TempHolder.OptionNames = NewoptionsList>
<cfset TempHolder.OptionPrices = NewOptionPriceList>
<cfset TempHolder.OptionWeights = NewOptionWeightList>
<cfset TempHolder.OptionItemIDs = NewoptionsItemIDList>
</cfif>

<cflock type="exclusive" scope="Session" timeout="10">
	<CFSET Session.OptionNames = #TempHolder.OptionNames#>
	<CFSET Session.OptionPrices = #TempHolder.OptionPrices#>
	<CFSET Session.OptionWeights = #TempHolder.OptionWeights#>
	<cfset Session.OptionItemIDs = TempHolder.OptionItemIDs>
</cflock>

<cfif isdefined('form.itemid')>
	<cflocation url = "dooptions.cfm?action=AddRadioList&itemid=#form.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=AddRadioList">
</cfif>