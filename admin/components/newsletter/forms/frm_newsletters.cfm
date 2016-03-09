<h2>Newsletters</h2>
<cfinclude template = "../queries/qry_published.cfm">
<strong><font size="3">Emails you have created are listed below:</font></strong>
<table width="95%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="20%" bgcolor="#0066CC"><strong><font color="#FFFFFF"> Created On </font></strong></td>
    <td width="50%" bgcolor="#0066CC"><strong><font color="#FFFFFF">Subject</font></strong></td>
    <td width="20%" bgcolor="#0066CC"><b><font color="#FFFFFF">Last Sent On</font></b> </td>
    <td width="10%" bgcolor="#0066CC">&nbsp;</td>
  </tr>
<cfoutput query = "qryPublished">
  <tr>
    <td nowrap="nowrap"><a href = "index.cfm?action=newsletter.manage.edit&id=#id#">#dateformat(createdon, "mm/dd/yyyy")# #timeformat(createdon, "hh:mm tt")#</a></td>
    <td><a href = "index.cfm?action=newsletter.manage.edit&id=#id#&mytoken=#mytoken#">#subject#</a></td>
    <td nowrap="nowrap"><cfif senton IS ''>Not sent yet.<cfelse>#dateformat(senton, "mm/dd/yyyy")# #timeformat(senton, "hh:mm tt")#</cfif></td>
    <td nowrap="nowrap"><a href = "index.cfm?action=newsletter.manage.PrepareToSend&id=#id#&mytoken=#mytoken#">Send</a> | <a href = "index.cfm?action=newsletter.manage.delete&id=#id#&mytoken=#mytoken#">Delete</a></td>
  </tr>
</cfoutput>
</table>
<p>&nbsp;</p>




















