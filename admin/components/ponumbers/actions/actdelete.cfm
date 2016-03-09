<cfquery name = "qryDeletePO" datasource="#request.dsn#">
DELETE FROM ponumbers
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm">















