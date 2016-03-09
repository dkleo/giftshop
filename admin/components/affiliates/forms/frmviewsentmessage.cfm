
<!---Mark this message as read--->
<cfinclude template = "../queries/qrysentmessage.cfm"> 
<cfloop query = "qrySentMessage">
<span class = "message">
  <cfoutput><h2>Viewing Message</h2>
    <strong>Message Sent on:</strong> #datesent#
    <p><strong>Message Sent To: </strong>#SentTo#</p>
    <p><strong>Subject: </strong>#subject#</p>
    <p><strong>Message: </strong>
	<p>#paragraphformat(body)#</p>
  </cfoutput> 
</span>
 </cfloop>












