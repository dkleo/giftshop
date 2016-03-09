<cfinclude template = "../queries/qry_groups.cfm">

<cfoutput>
  <h2>Newsletter Groups </h2>
  <form action="index.cfm?action=newsletter.groups.addgroup&mytoken=#mytoken#" method="post" name="addform">
<table width="300" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><input name="groupname" type="text" size="30"></td>
    <td width="20%"><input type="submit" name="Submit" value="Add"></td>
  </tr>
</table>
</form>
</cfoutput>
<br>
<table width="300" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="182" bgcolor="#000000"><font color="#FFFFFF"><b>Group Name </b></font></td>
    <td width="102" bgcolor="#000000"><font color="#FFFFFF">&nbsp;</font></td>
  </tr>
<cfoutput query = "qryGroups">
<form action="index.cfm?action=newsletter.groups.add&mytoken=#mytoken#" method="post" name="addform">
  <tr>
    <td><input type="text" name="groupname" size="25" value="#groupname#"><input type = "hidden" name="groupid" value="#groupid#"></td>
    <td width="20%"><center>
      <a href = "index.cfm?action=newsletter.groups.deletegroup&mytoken=#mytoken#&groupid=#groupid#">Delete</a>
    </center>
    </td>
  </tr>
</form>
</cfoutput>
</table>
<!---this files allows the user to manage newsletter groups--->



















