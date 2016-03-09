<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "MarkAsRead" datasource="#request.dsn#">
UPDATE afl_messages
SET wasread = 'Yes'
WHERE msgid = #url.msgid#
</cfquery>











