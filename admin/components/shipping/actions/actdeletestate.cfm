<cfquery name = "DeleteState" datasource="#request.dsn#">
DELETE FROM states
WHERE ID = #url.StateID#
</cfquery>

<cflocation url = "doshipping.cfm?action=editstates">


