<!---Mark this message as read--->
<cfinclude template = "../actions/actmarkread.cfm">
<cfinclude template = "../queries/qrymessage.cfm"> 
<cfloop query = "qryMessage">
<span class = "message">
  	<h2>Viewing Message</h2>
    <strong>Message Sent on:</strong> <cfoutput>#datesent#</cfoutput>
    <cfset senderid = #sender#>
    <cfinclude template = "../queries/qrysender.cfm">
			
			<cfif NOT qrySender.RecordCount IS 0>
			<p><strong>From: </strong><cfoutput>#qrySender.firstname# #qrySender.LastName# (#qryMessage.Sender#)</cfoutput></p>	
    	<cfelse>
				<b>From:</b> <cfoutput>#qryMessage.Sender#</cfoutput>
			</cfif>

    <p><strong>Subject: </strong><cfoutput>#subject#</cfoutput></p>
    <p><strong>Message: </strong>
		<p><cfoutput>#paragraphformat(body)#</cfoutput></p>

<cfoutput>
<form name="form1" method="post" action="index.cfm?action=messages.reply&replyto=#qryMessage.Sender#&msgid=#qryMessage.msgid#">
    <input type="submit" name="Submit" value="Reply to Sender">
  </form> 
</cfoutput>
</cfloop>

</span>












