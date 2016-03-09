<!---Get the list of options assigned to this product--->

<cfquery name="qryRemoveOption" datasource="#request.dsn#">
DELETE FROM products_options
WHERE optionid = #url.optionid# AND itemid = #url.itemid#
</cfquery>

<cflocation url = "dooptions.cfm?action=editoptions&itemid=#url.itemid#">


