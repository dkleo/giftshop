<!---THIS IS FOR UPDATING A DROP DOWN--->

<CFIF TempVar.IsEditing IS 'Yes'>

<!---Set up some temporary variables from the session variables--->
<cflock type="readonly" scope="Session" timeout="10">
<CFSET TempVar.OptionNames = '#session.OptionNames#'>
<CFSET TempVar.OptionPrices = '#session.OptionPrices#'>
<CFSET TempVar.OptionWeights = '#Session.OptionWeights#'>
<CFSET TempVar.OptionItemIDs = '#Session.OptionItemIDs#'>
</cflock>

<cfif #form.Caption# IS ''>
	<cfset ErrorMessage = "ERROR:  Please enter a caption for this drop down box!"> 
	<cflocation url = "dooptions.cfm?Action=AddDropDown&CaptionErrorLine=#ErrorLine#">
</cfif>

<cfinclude template = "../queries/qryOptions.cfm">

<cfif #qryOptions.RecordCount# is 0>
	<cfset NextOrderNumber = 1>
</cfif>

<cfif NOT #qryOptions.RecordCount# is 0>
<cfoutput query = "qryOptions">
	<cfset Thisorder = #orderid#>
</cfoutput>
	<cfset NextOrderNumber = ThisOrder + 1>
</cfif>

<cfset MyOptions = ''>

<cfquery name = "UpateOption" datasource="#request.dsn#">
UPDATE options
SET caption='#form.caption#',
cartcaption='#form.cartcaption#',
FieldValue='#form.DefaultValue#', 
ItemsList='#TempVar.OptionNames#', 
PriceList='#TempVar.OptionPrices#', 
WeightsList='#TempVar.OptionWeights#',
itemidlist='#Tempvar.OptionItemIDs#'
Height='#form.OptionSize#'
WHERE OptionID = #form.EditID#
</cfquery>

<!---Now Update the HTML Code--->

<cfset ThisFieldName = #form.EditID#>
<cfloop index="LoopCount" FROM="1" TO="#ListLen(TempVar.OptionNames, "^")#">
<CFSET ThisOptionName = #ListGetAt(TempVar.OptionNames, LoopCount, "^")#>
<CFSET ThisOptionItemID = #ListGetAt(TempVar.OptionItemIDs, LoopCount, "^")#>
<CFSET ThisOptionPrice = #ListGetAt(TempVar.OptionPrices, LoopCount, "^")#>
<CFSET ThisOptionWeight = #ListGetAt(TempVar.OptionWeights, LoopCount, "^")#>
	<cfif NOT ThisOptionName IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option value="#ThisOptionName#, #ThisOptionPrice#, No, #ThisOptionWeight#, #ThisOptionItemID#">#ThisOptionName#</option>'>
	</cfif>
	<cfif ThisOptionName IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option SELECTED value="#ThisOptionName#, #ThisOptionPrice#, No, #ThisOptionWeight#, #ThisOptionItemID#">#ThisOptionName#</option>'>
	</cfif>
</cfloop>
<cfset MyOptionCode = '<select size="#form.OptionSize#" name="ffield#ThisFieldName#">' & '#MyOptions#' & '</select>'>

<cfquery name = "UpdateHTMLCode" datasource="#request.dsn#">
	UPDATE options
	SET HTMLCode = '#MyOptionCode#'
	WHERE OptionID = #ThisFieldName#
</cfquery>
 
<H4 Align="Center">The Option Drop down box was updated</H4>

<cflock scope="Session" type="Exclusive" Timeout="10">
<cfset session.optionnames = "">
<cfset session.optionprices = "">
<cfset session.optionWeights = "">
<cfset session.optionitemids = "">
</cflock>
  
<cfif NOT form.itemid IS '0'>
	<cflocation url = "dooptions.cfm?action=editoptions&itemid=#form.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=editalloptions">
</cfif>

</CFIF>  