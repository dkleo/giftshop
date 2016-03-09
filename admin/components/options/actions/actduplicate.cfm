<cfquery name = "GetOptionToDuplicate" datasource="#request.dsn#">
SELECT * FROM options
WHERE optionid = #url.optionid#
</cfquery>

<!---Now copy the option--->


<cfloop query = "GetOptionToDuplicate">
<cfset NextOrderID = GetOptionToDuplicate.OrderID + 1>

<cfquery name = "InsertOptions" datasource="#request.dsn#">
INSERT INTO options
(FieldType, orderid, caption, Width, Height, FieldValue, isrequired, OptionPrice, OptionWeight, ItemsList, PriceList, WeightsList, HTMLCode, OptionGroup, cartcaption)
VALUES
('#FieldType#', #nextorderid#, '#caption#', '#Width#', '#Height#', '#FieldValue#', '#isrequired#', '#OptionPrice#', '#OptionWeight#', '#ItemsList#', '#PriceList#', '#WeightsList#', '#HTMLCode#', '#OptionGroup#', '#cartcaption#')
</cfquery>

</cfloop>

<cfquery name = "FindOption" datasource="#request.dsn#">
SELECT * FROM options
Order by optionid ASC
</cfquery>

<cfoutput query = "FindOption">
	<cfset newoption = optionid>
    <cfset oldhtml = htmlcode>
</cfoutput>

<cfset replacestring = 'ffield#GetOptionToDuplicate.optionid#'>
<cfset replacewithstring = 'ffield#newoption#'>
<cfset NewHTML = replacenocase(oldhtml, replacestring, replacewithstring, "ALL")>

<cfquery name = "qryUpdateHTML" datasource="#request.dsn#">
UPDATE options
SET HTMLCode = '#NewHTML#'
WHERE optionid = #newoption#
</cfquery>

<!---Now assign this option to the selected product--->
<cfquery name = "UpdateProductOptions" datasource="#request.dsn#">
INSERT INTO products_options
(optionid, itemid)
VALUES
(#newoption#, #url.itemid#)
</cfquery>

<cflocation url = "dooptions.cfm?action=editoptions&ItemID=#url.ItemID#">

