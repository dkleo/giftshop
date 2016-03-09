<cfquery name = "DeleteSale" datasource="#request.dsn#">
DELETE FROM sales WHERE saleid = #url.saleid#
</cfquery>

<cflocation url="dosales.cfm">















