<cfquery name = "qryMessage" datasource="#request.dsn#">
SELECT * FROM afl_messages
WHERE msgid = '#url.msgid#'
</cfquery>












