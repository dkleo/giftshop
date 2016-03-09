<cfinclude template = "../queries/qryusers.cfm">

<h2>Users <cfoutput><a href = "#request.AdminPath#helpdocs/users_admin.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<p><strong><a href="index.cfm?action=add"><img src="icons/adduser.jpg" width="32" height="32" border="0"> 
  Add New User</a></strong></p>
<table width="600" border="0" cellspacing="0" cellpadding="4">
  <tr bgcolor="#0033CC"> 
    <td bgcolor="#000000"><strong><font color="#FFFFFF">Username</font></strong></td>
    <td bgcolor="#000000"><div align="center"><strong><font color="#FFFFFF">Remove User</font></strong></div></td>
  </tr>
  <cfoutput query = "qryUsers"> 
    <cfif NOT userlevel IS 'SuperAdmin'>
    <tr> 
      <td><a href = "index.cfm?action=Edit&UserID=#userid#">#username#</a></td>
      <td><div align="center"><a href = "index.cfm?action=DeleteUser&userid=#userid#">Delete</a></div></td>
    </tr>
    </cfif>
  </cfoutput> 
</table>
<p><strong></strong></p>

















