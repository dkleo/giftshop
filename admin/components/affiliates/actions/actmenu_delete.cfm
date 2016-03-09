<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qDelete" datasource="#request.dsn#">
DELETE FROM afl_menu
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm?action=menu">