<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages
WHERE recipient = 'admin'
ORDER BY datesent DESC
</cfquery>












