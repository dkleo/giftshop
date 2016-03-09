<cfquery name = "qryTickets" datasource="#request.dsn#">
SELECT * FROM support_tickets
<cfif NOT isdefined('url.ticketid')>
WHERE status = 'Closed'
<cfelse>
WHERE ticketid = '#url.ticketid#'
</cfif>
</cfquery>
















