<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---deletes an error from existance--->
<cfquery name="qDeleteError" datasource="#request.dsn#">
DELETE FROM errorlog
WHERE id = #url.id#
</cfquery>

<cflocation url = "dosetup.cfm?action=viewerrors">