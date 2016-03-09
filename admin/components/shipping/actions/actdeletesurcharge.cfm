<cfquery name="DeleteSurcharge" datasource="#request.dsn#">
DELETE FROM shippingsurcharges
WHERE ChargeID = #url.ChargeID#
</cfquery>

<cflocation url = "doshipping.cfm?action=surcharge">
