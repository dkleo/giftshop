<cfinclude template = "../queries/qrytickets.cfm">
<cfinclude template = "../queries/qryreplies.cfm">

<table width="98%" align="center" cellpadding="4" cellspacing="0">
<tr>
<td>
<cfoutput query = "qryTickets">
<cfset repid = #supportrep#>
<strong>Customer Wrote:</strong>
<p>
#htmleditformat(message)#
</cfoutput>

<cfif qryReplies.recordcount IS 0>
<p style="font-weight: bold; font-style: italic">
There are no responses to this ticket yet.
<cfelse>
<!---get rep name--->
<cfquery name = "qryReps" datasource="#request.dsn#">
SELECT username FROM users
WHERE userid = '#repid#'
</cfquery>

<cfset repname = ''>
<cfoutput query = "qryReps">
	<cfset repname = '#username#'>
</cfoutput>

<cfoutput query = "qryReplies">
<p><strong>Reply From #replyby#: <cfif status IS 'unread'>New Reply!</cfif></strong>
<p>
#reply#
</p>
</cfoutput>
</cfif>

<cfif qryTickets.nextaction IS 'Waiting for Reply'>
	<p>
	<cfif NOT qryTickets.status IS 'Closed'>
	<em>Waiting on customer to respond.</em>
		<p>
		<cfoutput>
		<form method="post" action="index.cfm?action=replytoticket">
		<input type = "hidden" name = "ticketid" value="#qryTickets.ticketid#" />
		<input type = "submit" name="closeticket" value="Close This Ticket" />
		</form>
		</cfoutput>
	</cfif>
	<cfif qryTickets.status IS 'Closed'>
	<em>Waiting on customer to read your final response.</em>
	</cfif>
<cfelse>
<cfif NOT qryTickets.status IS 'Closed'>
	<p>
	Post a response to this ticket:
	<br />
	<form method="post" action="index.cfm?action=replytoticket">
	<cfoutput><input type = "hidden" name = "ticketid" value="#qryTickets.ticketid#" /></cfoutput>
	<textarea name="ticketreply" cols="50" rows="8"></textarea>
	<br />
	<input name="closeticket" type="checkbox" id="closeticket" value="closeticket" />
	Mark Ticket as Closed<br />
	<input type = "submit" name="replytoticketsubmit" value="Post Reply" />
	</form>
<cfelse>
	<b>TICKET HAS BEEN CLOSED.
	<p>
	RESOLUTION:</b>
	<br />
	<cfoutput>#qryTickets.resolution#</cfoutput>
	</p>
</cfif>

</cfif>
</td>
</tr>
</table>
<!---Set status of all replies to read since the rep has looked at the ticket (only replies NOT by them).--->
<cfquery name = "qryUpdateReplyStatus" datasource="#request.dsn#">
UPDATE support_replies
SET status = 'read'
WHERE ticketid = '#qryTickets.ticketid#'
</cfquery>
<p>
<cfif NOT qryTickets.status iS 'Closed'><a href = "index.cfm">Go back to tickets</a>
<cfelse><a href = "index.cfm?action=closedtickets">Go back to tickets</a>
</cfif>















