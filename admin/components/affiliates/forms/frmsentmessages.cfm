<STYLE>
  .unread {font-weight: bold; cursor: pointer;}
  .selecttr { background-color: ; cursor: pointer;}
  .initial { background-color: ; color: ; cursor: pointer; }
  .normal { background-color: ; cursor: pointer; }
  .normalbold {font-weight: bold; cursor: pointer;}
  .highlight { background-color: #FFFF99; cursor: pointer; }
  .highlightbold { background-color: #FFFF99; cursor: pointer; font-weight: bold; }
</style>

<script language="JavaScript">
 function ViewSent(messageid){
	window.location.href = 'index.cfm?action=messages.viewsentmessage&msgid=' + messageid;
 }
</script>

<cfinclude template = "../queries/qrysent.cfm">

<h2>Sent Messages</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000099"> 
    <td width="21%" height="25"><strong><font color="#FFFFFF" size="2">To</font></strong></td>
    <td width="43%"><strong><font color="#FFFFFF" size="2">Subject</font></strong></td>
    <td width="33%"><strong><font color="#FFFFFF" size="2">Date</font></strong></td>
    <td width="5%">&nbsp;</td>
  </tr>
  <cfloop query = "qrySent">
    <tr onMouseOver="this.className='highlightbold'" onMouseOut="this.className='normalbold'" class="unread"> 
      <td <cfoutput>onclick="ViewSent(#msgid#);"</cfoutput>> 
         <cfset senderid = #SentTo#>
					<cfinclude template = "../queries/qrysender.cfm">	
				 	<cfif qrySender.recordcount IS 0>
					<cfoutput>#qrySent.SentTo#</cfoutput>
					<cfelse>
					<cfoutput>#qrySender.FirstName# #qrySender.LastName# (#qrySent.SentTo#)</cfoutput>
					</cfif>					</td>
        <td height="25" <cfoutput>onclick="ViewSent(#msgid#);"</cfoutput>><cfoutput>#subject#</cfoutput></td>
        <td <cfoutput>onclick="ViewSent(#msgid#);"</cfoutput>><cfoutput>#datesent#</cfoutput></td>
        <td><cfoutput><a href = "index.cfm?action=messages.delete&msgid=#msgid#&wasdoing=sentmsgs"><img src="../../icons/delete.gif" width="16" height="16" border="0" /></a></cfoutput></td>
     </tr>
  </cfloop>
</table>
<p align="center"><strong></strong></p>













