<p><strong><font size="3">New User</font></strong></p>
<form name="form1" method="post" action="index.cfm">
  <table width="62%" border="0" cellspacing="0" cellpadding="4">
    <tr> 
      <td width="59%"><p>Username: <br>
        </p></td>
      <td width="41%"><input name="newusername" type="text" id="newusername"></td>
    </tr>
    <tr>
      <td>Password: </td>
      <td><input name="newpassword" type="password" id="newpassword"></td>
    </tr>
    <tr>
      <td>Retype Password:</td>
      <td><input name="newpassword_confirm" type="password" id="newpassword_confirm" /></td>
    </tr>
    <tr> 
      <td>User Level:</td>
      <td><select name="userlevel" id="userlevel">
          <option>User</option>
          <option>Admin</option>
        </select></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="center"> 
          <input type="hidden" name="action" value="AddUser">
          <input type="submit" name="Submit" value="Add User">
        </div></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>
<p>&nbsp;</p>

















