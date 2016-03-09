<cfinclude template = "../queries/qrygroups.cfm">

<cfoutput>
  <h2>Affiliate Groups </h2>
  <form action="index.cfm?action=groups.add" method="post" name="addform">
<table width="650" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td>New Group Name:
      <input name="groupname" type="text" size="35"></td>
    <td width="20%"><div align="right">
      <input type="submit" name="Submit" value="Add">
    </div></td>
  </tr>
</table>
</form>
</cfoutput>
<br>
<table width="650" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="50" bgcolor="#000000"><b><font color="#FFFFFF">ID</font></b></td>
    <td width="182" bgcolor="#000000"><font color="#FFFFFF"><b>Group Name </b></font></td>
    <td width="102" bgcolor="#000000"><font color="#FFFFFF">&nbsp;</font></td>
  </tr>
<cfoutput query = "qryGroups">
<form action="index.cfm?action=groups.update" method="post" name="updateform">
  <tr>
    <td>#groupid#</td>
    <td><input type="text" name="groupname" size="25" value="#groupname#"><input type = "hidden" name="groupid" value="#groupid#"><input type = "submit" value = "Update" name="submit"></td>
    <td width="20%"><center>
      <a href = "index.cfm?action=groups.delete&groupid=#groupid#">Delete</a>
    </center>    </td>
  </tr>
</form>
</cfoutput>
</table>












