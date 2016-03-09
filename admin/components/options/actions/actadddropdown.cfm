
<cflock scope="Session" Type="readonly" timeout="10">
	<cfset TempVar.IsEditing = Session.IsEditing>
</cflock>


<CFIF NOT TempVar.IsEditing IS 'Yes'>
<!---Set up some temporary variables from the session variables--->
<cflock type="readonly" scope="Session" timeout="10">
<CFSET TempVar.OptionNames = '#session.OptionNames#'>
<CFSET TempVar.OptionPrices = '#session.OptionPrices#'>
<CFSET TempVar.OptionWeights = '#Session.OptionWeights#'>
<cfset TempVar.OptionItemIDs = '#session.OptionItemIDs#'>
</cflock>

<cfif #form.Caption# IS ''>
	<cfset ErrorMessage = "ERROR:  Please enter a caption for this drop down box!"> 
	<cflocation url = "dooptions.cfm?Action=AddDropDown&CaptionError=#ErrorMessage#">
</cfif>

<cfif #form.OptionSize# IS ''>
	<cfset ErrorMessage = "ERROR:  Please enter a size of at least 0 for this option drop down!"> 
	<cflocation url = "dooptions.cfm?Action=AddDropDown&CaptionError=#ErrorMessage#">
</cfif>

<cfinclude template = "../queries/qryoptions.cfm">

<cfif #qryOptions.RecordCount# is 0>
	<cfset NextOrderNumber = 1>
</cfif>

<cfif NOT #qryOptions.RecordCount# is 0>
<cfoutput query = "qryOptions">
	<cfset Thisorder = #orderid#>
</cfoutput>
	<cfset NextOrderNumber = ThisOrder + 1>
</cfif>

<!---Now create the HTML code for this option--->
<cfset MyOptions = ''>

<cfquery name = "InsertOptions" datasource="#request.dsn#">
INSERT INTO options
(orderid, caption, FieldType, FieldValue, ItemsList, PriceList, WeightsList, itemidslist, Height, cartcaption)
VALUES
(#NextOrderNumber#, '#form.caption#', 'DropDown', '#form.DefaultValue#', '#TempVar.OptionNames#', '#TempVar.OptionPrices#', '#TempVar.OptionWeights#', '#TempVar.OptionItemIDs#', '#form.OptionSize#', '#form.cartcaption#')</cfquery>

<cfquery name = "FindOption" datasource="#request.dsn#">
SELECT * FROM options
WHERE OrderID = #NextOrderNumber#
</cfquery>

<cfset ThisFieldName = #FindOption.OptionID#>

<cfloop index="LoopCount" FROM="1" TO="#ListLen(TempVar.OptionNames, "^")#">
<CFSET ThisOptionName = #ListGetAt(TempVar.OptionNames, LoopCount, "^")#>
<CFSET ThisOptionPrice = #ListGetAt(TempVar.OptionPrices, LoopCount, "^")#>
<CFSET ThisOptionWeight = #ListGetAt(TempVar.OptionWeights, LoopCount, "^")#>
<CFSET ThisOptionItemID = #ListGetAt(TempVar.OptionItemIDs, LoopCount, "^")#>
	<cfif NOT LoopCount IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option value="#LoopCount#">#ThisOptionName#</option>'>
	</cfif>
	<cfif LoopCount IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option value="#LoopCount#" selected="selected">#ThisOptionName#</option>'>
	</cfif>

</cfloop>
<cfset MyOptionCode = '<select size="#form.OptionSize#" name="ffield#ThisFieldName#">' & '#MyOptions#' & '</select>'>

<cfquery name = "UpdateHTMLCode" datasource="#request.dsn#">
	UPDATE options
	SET HTMLCode = '#MyOptionCode#'
	WHERE OptionID = #ThisFieldName#
</cfquery>
 
<cfif NOT form.itemid IS '0'>
<!---Now assign this option to the selected product--->
    <cfquery name = "InsertOption" datasource="#request.dsn#">
    INSERT INTO products_options
    (optionid, itemid)
    VALUES
    (#ThisFieldName#, #form.itemid#)
    </cfquery>
</cfif>

<H4 Align="Center">The Option Drop down box was created</H4>

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
itemidslist='#Tempvar.OptionItemIDs#',
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
	<cfif NOT LoopCount IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option value="#LoopCount#">#ThisOptionName#</option>'>
	</cfif>
	<cfif LoopCount IS #form.DefaultValue#>
		<cfset MyOptions =  #MyOptions# & '<option value="#LoopCount#" selected="selected">#ThisOptionName#</option>'>
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