<cfquery name = "qrySentMessage" datasource="#request.dsn#">
SELECT * FROM afl_messages_sent
WHERE msgid = '#url.msgid#'
</cfquery>












