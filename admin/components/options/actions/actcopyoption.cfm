<!---Duplicate the option and then assign it to this item--->
<cfquery name = "GetOptionToDuplicate" datasource="#request.dsn#">
SELECT * FROM options
WHERE optionid = #url.optionid#
</cfquery>

<!---Now copy the option--->
<cfloop query = "GetOptionToDuplicate">
<cfset NextOrderID = GetOptionToDuplicate.OrderID + 1>

<cfquery name = "InsertOptions" datasource="#request.dsn#">
INSERT INTO options
(FieldType, orderid, caption, Width, Height, FieldValue, isrequired, OptionPrice, OptionWeight, ItemsList, PriceList, WeightsList, HTMLCode, OptionGroup, cartcaption, itemidslist, itemid)
VALUES
('#FieldType#', #nextorderid#, '#caption#', '#Width#', '#Height#', '#FieldValue#', '#isrequired#', '#OptionPrice#', '#OptionWeight#', '#ItemsList#', '#PriceList#', '#WeightsList#', '#HTMLCode#', '#OptionGroup#', '#cartcaption#', '#itemidslist#', '#itemid#')
</cfquery>
</cfloop>

<cfquery name = "FindOption" datasource="#request.dsn#">
SELECT * FROM options
Order by optionid ASC
</cfquery>

<cfoutput query = "FindOption">
	<cfset newoption = optionid>
</cfoutput>

<!---Copy the selected option to the product and then return to options for that product--->
<cfquery name = "InsertOption" datasource="#request.dsn#">
INSERT INTO products_options
(optionid, itemid)
VALUES
('#newoption#', '#url.copyto#')
</cfquery>

<cflocation url = "dooptions.cfm?action=editoptions&itemid=#url.copyto#">

