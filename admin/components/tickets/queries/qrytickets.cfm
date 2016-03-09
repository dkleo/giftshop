<cfquery name = "qryTickets" datasource="#request.dsn#">
SELECT * FROM support_tickets
<cfif NOT isdefined('url.ticketid')>
WHERE status = 'Open' OR status = 'Submitted'
<cfelse>
WHERE ticketid = '#url.ticketid#'
</cfif>
</cfquery>
















