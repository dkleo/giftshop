<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Enters a response/update for this ticket--->
<cfif isdefined('form.ticketreply')>
	<cfquery name = "qryInsertResponse" datasource="#request.dsn#">
	INSERT INTO support_replies
	(ticketid, reply, replyby, status)
	VALUES
	('#form.ticketid#', '#form.ticketreply#', '#request.companyname#', 'unread')
	</cfquery>
	
	<!---Set this ticket to open--->
	<!---Set the status of this ticket to open since this person responded to it--->
	<cfquery name = "qryUpdateStatus" datasource="#request.dsn#">
	UPDATE support_tickets
	SET status = 'Open',
	nextaction = 'Waiting For Reply'
	WHERE ticketid = '#form.ticketid#'
	</cfquery>

	<!---Get the repid for this ticket then get the reps email address--->
	<cfquery name = "qryGetTicket" datasource="#request.dsn#">
	SELECT * FROM support_tickets
	WHERE ticketid = '#form.ticketid#'
	</cfquery>
	
	<!---Notify the customer by email--->
	<cfif request.UseMailServer IS 'Yes'>
    	<cfif request.UseMailLogin IS 'Yes'>
            <cfmail server="#request.MailServer#"
            username="#request.mailuser#"
            Password="#request.mailpassword#"
            From="#request.emailaddress#"
            TO="#qryGetTicket.emailaddress#"
            SUBJECT="SUPPORT TICKET #form.TicketID# UPDATED!"
            type="html">
            Your support ticket (ID: <b>#form.ticketID#</b>) has received a response.<br />
            To read the response, please login to your account on our website.  DO NOT reply to this email message.<br />
            Login to your account to read the response and respond to it.
            </cfmail>
		<cfelse>
            <cfmail server="#request.MailServer#"
            From="#request.emailaddress#"
            TO="#qryGetTicket.emailaddress#"
            SUBJECT="SUPPORT TICKET #form.TicketID# UPDATED!"
            type="html">
            Your support ticket (ID: <b>#form.ticketID#</b>) has received a response.<br />
            To read the response, please login to your account on our website.  DO NOT reply to this email message.<br />
            Login to your account to read the response and respond to it.
            </cfmail>        
        </cfif>
    <cfelse>
    	<cfif request.UseMailLogin IS 'Yes'>
            <cfmail username="#request.mailuser#"
            Password="#request.mailpassword#"
            From="#request.emailaddress#"
            TO="#qryGetTicket.emailaddress#"
            SUBJECT="SUPPORT TICKET #form.TicketID# UPDATED!"
            type="html">
            Your support ticket (ID: <b>#form.ticketID#</b>) has received a response.<br />
            To read the response, please login to your account on our website.  DO NOT reply to this email message.<br />
            Login to your account to read the response and respond to it.
            </cfmail>
         <cfelse>
            <cfmail From="#request.emailaddress#"
            TO="#qryGetTicket.emailaddress#"
            SUBJECT="SUPPORT TICKET #form.TicketID# UPDATED!"
            type="html">
            Your support ticket (ID: <b>#form.ticketID#</b>) has received a response.<br />
            To read the response, please login to your account on our website.  DO NOT reply to this email message.<br />
            Login to your account to read the response and respond to it.
            </cfmail>         
         </cfif>	    
    </cfif>
	<b>Your response has been posted!</b>
	<p>
</cfif>

<!---Check to see if the ticket should be closed--->
<cfinclude template = "actcloseticket.cfm">
<a href = "index.cfm">Back to tickets</a>















