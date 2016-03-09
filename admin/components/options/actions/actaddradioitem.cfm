<!---This script adds an option to the drop down menu.  It uses session variables
to track the items being added--->
<cfoutput>
<cfif #form.ThisOptionName# IS ''>
<cfset ErrorMessage = "You need to specify a name for this list item!"> 
<cfset ErrorLine = 1>
<cfset frmCaption = form.ThisOptionName>
<cfset frmWeight = form.ThisOptionWeight>
<cfset frmPrice = form.ThisOptionPrice>
<cfset frmItemID = form.ThisOptionItemid>
<cfif len(trim(frmItemID)) IS 0>
	<cfset frmItemID = '0'>
</cfif>
<cfif ISDEFINED('form.itemid')>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#&itemid=#form.itemid#">
<cfelse>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#">
</cfif>

</cfif>

<cfif #form.ThisOptionPrice# IS ''>
<cfset ErrorMessage = "Please Set a price for this item (set to 0.00 if no price)!"> 
<cfset ErrorLine = 2>
<cfset frmCaption = form.ThisOptionName>
<cfset frmWeight = form.ThisOptionWeight>
<cfset frmPrice = form.ThisOptionPrice>
<cfset frmItemID = form.ThisOptionItemid>
<cfif len(trim(frmItemID)) IS 0>
	<cfset frmItemID = '0'>
</cfif>
<cfif ISDEFINED('form.itemid')>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#&itemid=#form.itemid#">
<cfelse>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#">
</cfif>

</cfif>

<cfif #form.ThisOptionWeight# IS ''>
<cfset ErrorMessage = "Please Set a weight for this item! (set to 0.00 if no weight)"> 
<cfset ErrorLine = 3>
<cfset frmCaption = form.ThisOptionName>
<cfset frmWeight = form.ThisOptionWeight>
<cfset frmPrice = form.ThisOptionPrice>
<cfset frmItemID = form.ThisOptionItemid>
<cfif len(trim(frmItemID)) IS 0>
	<cfset frmItemID = '0'>
</cfif>
<cfif ISDEFINED('form.itemid')>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#&itemid=#form.itemid#">
<cfelse>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#">
</cfif>

</cfif>

<cfif NOT isnumeric(form.ThisOptionPrice)>
<cfset ErrorMessage = "The Price must be numeric.  Do NOT enter a symbol"> 
<cfset ErrorLine = 2>
<cfset frmCaption = form.ThisOptionName>
<cfset frmWeight = form.ThisOptionWeight>
<cfset frmPrice = form.ThisOptionPrice>
<cfset frmItemID = form.ThisOptionItemid>
<cfif len(trim(frmItemID)) IS 0>
	<cfset frmItemID = '0'>
</cfif>
<cfif ISDEFINED('form.itemid')>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#&itemid=#form.itemid#">
<cfelse>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#">
</cfif>

</cfif>

<cfif NOT isnumeric(form.ThisOptionWeight)>
<cfset ErrorMessage = "The Weight must be numeric.  Do NOT enter a symbol"> 
<cfset ErrorLine = 3>
<cfset frmCaption = form.ThisOptionName>
<cfset frmWeight = form.ThisOptionWeight>
<cfset frmPrice = form.ThisOptionPrice>
<cfset frmItemID = form.ThisOptionItemid>
<cfif len(trim(frmItemID)) IS 0>
	<cfset frmItemID = '0'>
</cfif>
<cfif ISDEFINED('form.itemid')>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#&itemid=#form.itemid#">
<cfelse>
<cflocation url = "dooptions.cfm?Action=AddRadioList&AddErrorLine=#ErrorLine#&AddErrorMessage=#ErrorMessage#&AddWeight=#frmWeight#&AddPrice=#frmPrice#&AddCaption=#frmCaption#&AddItemID=#frmItemID#">
</cfif>
<cfabort>
</cfif>

<cfif len(trim(form.ThisOptionItemID)) IS 0>
	<cfset form.ThisOptionItemID = 0>
</cfif>

<cflock scope = "session" type="readonly" timeout="10">
<CFSET NewoptionsList = ListAppend(#session.OptionNames#, #form.ThisOptionName#, "^")>
<CFSET NewOptionPriceList = ListAppend(#session.OptionPrices#, #form.ThisOptionPrice#, "^")>
<CFSET NewOptionWeightList = ListAppend(#session.OptionWeights#, #form.ThisOptionWeight#, "^")>
<CFSET NewOptionItemIDList = ListAppend(#session.OptionItemIDs#, #form.ThisOptionItemID#, "^")>
</cflock>

<cflock type="exclusive" scope="Session" timeout="10">
<CFSET Session.OptionNames = #NewoptionsList#>
<CFSET Session.OptionPrices = #NewOptionPriceList#>
<CFSET Session.OptionWeights = #NewOptionWeightList#>
<CFSET Session.OptionItemIDs = #NewOptionItemIDList#>
</cflock>

</cfoutput>
<cfif ISDEFINED('form.itemid')>
	<cflocation url = "dooptions.cfm?action=AddRadioList&itemid=#form.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=AddRadioList">
</cfif>

