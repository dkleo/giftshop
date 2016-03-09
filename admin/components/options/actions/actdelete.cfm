<!---deletes and option form field--->
<cfquery name = "DeleteDropDown" datasource="#request.dsn#">
DELETE FROM options
WHERE OptionID = #url.optionid#
</cfquery>

<cfquery name = "DeleteDropDown" datasource="#request.dsn#">
DELETE FROM products_options
WHERE OptionID = #url.optionid#
</cfquery>

<cfif NOT url.itemid IS '0'>
	<cflocation url = "dooptions.cfm?action=editoptions&itemid=#url.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=editalloptions">
</cfif>


