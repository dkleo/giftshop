<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM messages
WHERE recipient = 'admin'
</cfquery>












