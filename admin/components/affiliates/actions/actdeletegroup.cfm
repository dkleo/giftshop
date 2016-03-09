<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qDeleteGroup" datasource="#request.dsn#">
DELETE FROM afl_groups WHERE groupid = '#url.groupid#'
</cfquery>
<cflocation url = "index.cfm?action=groups.groups">











