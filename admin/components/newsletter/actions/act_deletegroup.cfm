<cfquery name = "qDeleteGroup" datasource="#request.dsn#">
DELETE FROM nl_groups WHERE groupid = #url.groupid#
</cfquery>

<cfquery name = "qDeleteGroup" datasource="#request.dsn#">
DELETE FROM nl_membersingroup WHERE groupid = #url.groupid#
</cfquery>

<cflocation url = "index.cfm?action=newsletter.groups.groups&mytoken=#mytoken#">



















