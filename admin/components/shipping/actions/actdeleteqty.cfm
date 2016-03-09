<cfquery name = "DeleteShippingOption" datasource="#request.dsn#">
DELETE FROM shippingtable4
WHERE ShippingID = #url.shippingID#
</cfquery>
<cflocation url = "doshipping.cfm?action=EditQuantityTable">
