<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qClearSetting" datasource="#request.dsn#">
UPDATE cfsk_processors SET #url.clearwhat# = ''
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm?action=settings&id=#id#">