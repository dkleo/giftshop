<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qUpdateGroup" datasource="#request.dsn#">
UPDATE afl_groups SET groupname = '#form.groupname#' WHERE groupid = '#form.groupID#'
</cfquery>

<cflocation url = "index.cfm?action=groups.groups">











