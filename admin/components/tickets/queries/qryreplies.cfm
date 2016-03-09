<cfquery name = "qryReplies" datasource="#request.dsn#">
SELECT * FROM support_replies
WHERE ticketid = '#url.ticketid#'
</cfquery>















