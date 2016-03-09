<cfquery name = "DeleteShippingOption" datasource="#request.dsn#">
DELETE FROM shippingtable1
WHERE ShippingID = #url.shippingID#
</cfquery>
<cflocation url = "doshipping.cfm?action=EditOne">
