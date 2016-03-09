<p align="left"><font size="3"><strong>Password Change</strong></font> <cfoutput><a href = "#request.AdminPath#helpdocs/change_password.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></p>
<i>Change the Password for your login here.</i> 
<form method="POST" action="dosetup.cfm">
    
  <table width="75%" border="0" cellspacing="0" cellpadding="0" align="left">
    <tr> 
      <td width="49%"></td>
	  <cfoutput>
	  <td width="51%"><input type = "hidden" value="#cookie.admin_username#" name="EditThisUser"> 
	  </td></cfoutput>
      
    </tr>
    <tr>
      <td>Username:</td>
      <td><cfoutput>
	  <input name="ChangeUserName" type="text" size="20" Value="#cookie.admin_username#">
	  </cfoutput></td>
    </tr>
    <tr> 
      <td width="49%">Old Password:</td>
      <td width="51%"> <input type="Password" name="ChangePasswordOld" size="20"> 
      </td>
    </tr>
    <tr> 
      <td width="49%">New Password:</td>
      <td width="51%"> <input type="Password" name="ChangePasswordNew" size="20"> 
      </td>
    </tr>
    <tr> 
      <td width="49%">New Password Confirm:</td>
      <td width="51%"> <input type="Password" name="ChangePasswordConfirm" size="20"> 
      </td>
    </tr>
  </table>
    <input type="hidden" name="action" value="ChangePassword">
    <input type="submit" value="Change Password" name="B1">
</form>








