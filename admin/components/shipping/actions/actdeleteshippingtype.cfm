<cfquery name = "DeleteShippingType" datasource="#request.dsn#">
DELETE FROM shippingtypes
WHERE id = #url.ShippingID#
</cfquery>

<cflocation url = "doshipping.cfm?action=EditShippingTypes&ReturnPath=#url.ReturnPath#">

