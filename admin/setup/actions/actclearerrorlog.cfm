<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qryClearErrorLog" datasource="#request.dsn#">
DELETE FROM errorlog
</cfquery>

<h2>Error Log</h2>

<cflocation url = "dosetup.cfm?action=viewerrors">






