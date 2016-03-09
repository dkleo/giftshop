<cfquery name = "DeleteShippingOption" datasource="#request.dsn#">
DELETE FROM shippingtable2
WHERE ShippingID = #url.shippingID#
</cfquery>
<cflocation url = "doshipping.cfm?action=EditTwo">
