<cfquery name = "DeleteShippingOption" datasource="#request.dsn#">
DELETE FROM shippingtable5
WHERE ShippingID = #url.shippingID#
</cfquery>
<cflocation url = "doshipping.cfm?action=EditFive">
