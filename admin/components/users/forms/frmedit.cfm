<cfinclude template = '../queries/qryusers.cfm'>

<p><strong><font size="3">Edit User</font></strong></p>
<cfoutput query = "qryUsers">
<form name="form1" method="post" action="index.cfm">
  <table width="62%" border="0" cellspacing="0" cellpadding="4">
    <tr> 
      <td width="59%"><p>Username: <br>
        </p></td>
      <td width="41%">#username#</td>
    </tr>
    <tr> 
      <td>Reset Password to: </td>
      <td><input name="newpassword" type="password" id="newpassword" value=""></td>
    </tr>
    
    <tr>
      <td>Retype Password:</td>
      <td><input name="newpassword_confirm" type="password" id="newpassword_confirm" value="" /></td>
    </tr>
    <tr> 
      <td>User Level:</td>
      <td><select name="userlevel" id="userlevel">
          <option <cfif userlevel IS 'User'>SELECTED</cfif>>User</option>
          <option <cfif userlevel IS 'Admin'>SELECTED</cfif>>Admin</option>
        </select></td>
    </tr>
    
    <tr> 
      <td colspan="2"><div align="center"> 
	  	  <input type="hidden" name="userid" value="#url.userid#">
          <input type="hidden" name="action" value="UpdateUser">
          <input type="submit" name="Submit" value="Update User">
        </div></td>
    </tr>
  </table>
</form>
</cfoutput>
</body>
</html>
















