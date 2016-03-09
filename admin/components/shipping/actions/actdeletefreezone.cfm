<cfquery name="DeleteFreezone" datasource="#request.dsn#">
DELETE FROM shippingfreezones
WHERE ID = #url.ID#
</cfquery>

<cflocation url = "doshipping.cfm?action=freezones">
