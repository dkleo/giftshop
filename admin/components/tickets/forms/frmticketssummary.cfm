<cfinclude template = "../queries/qrytickets.cfm">

<h2><strong>Open Support Tickets</strong> [<a href="components/tickets/index.cfm?action=closedtickets">View Closed Tickets</a>]</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  
  <tr>
    <td width="20%" align="left" bgcolor="#000000"><span class="tdheader" style="color: #FFFFFF; font-weight: bold">Date Submitted </span></td>
    <td width="25%" align="left" bgcolor="#000000"><span class="tdheader" style="color: #FFFFFF; font-weight: bold">Subject</span></td>
    <td width="10%" bgcolor="#000000"><span class="tdheader" style="color: #FFFFFF; font-weight: bold">Status</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">CustomerID</span></td>
    <td width="20%" align="left" bgcolor="#000000"><span style="font-weight: bold; color: #FFFFFF">Next Action</span></td>
    <td align="left" bgcolor="#000000"><span class="tdheader" style="color: #FFFFFF; font-weight: bold">TicketID</span></td>
  </tr>
  <cfoutput query = "qryTickets">
  <tr>
    <td align="left" class="td">#dateformat(datesubmitted, "mm-dd-yyyy")#:#timeformat(datesubmitted, "h-mm t")#</td>
    <td align="left" class="td">#title#</td>
    <td align="left" class="td">#status#</td>
    <td align="left" class="td">#CustomerID#</td>
    <td align="left" class="td">#nextaction# <cfif nextaction IS 'Reply Needed'><b>Updated!</b></cfif></td>
    <td align="left" class="td"><a href="components/tickets/index.cfm?action=readticket&ticketid=#ticketid#&status=#status#">#ticketid#</a></td>
  </tr>
  </cfoutput>
</table>








