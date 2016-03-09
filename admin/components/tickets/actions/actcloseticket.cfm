<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfif isdefined('form.closeticket')>
	<cfif NOT isdefined('form.resolution')>
		<h4>Closing Ticket</h4>
		<p>You have marked a ticket to be closed after your response.  You need to provide a summary of what the solution was.<br>
		  <cfoutput>
		  <form method="post" action="index.cfm?action=closeticket&ticketid=#form.ticketid#">
		  <textarea name="resolution" cols="50" rows="10"></textarea>
		  <input type = "hidden" name = "closeticket" value="CloseTicket">
		<br><input type = "submit" value="Close Ticket" name="clostticketsubmit">
		</form>
		</cfoutput>
	</cfif>
	
	<cfif ISDEFINED('form.resolution')>
		<cfquery name = "qryCloseTicket" datasource="#request.dsn#">
		UPDATE support_tickets
		SET status = 'Closed',
		resolution = '#form.resolution#'
		WHERE ticketid = '#url.ticketid#'
		</cfquery>
		This ticket is now closed.
		<p>
		<a href = "index.cfm">Go back to tickets</a>
	</cfif>
</cfif>
















