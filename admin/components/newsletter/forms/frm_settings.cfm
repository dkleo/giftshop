<cfinclude template = "../queries/qry_settings.cfm">
<h2>Newsletter Settings</h2>
<form method = "post" <cfoutput>action="index.cfm?action=newsletter.settings.savesettings&mytoken=#mytoken#" </cfoutput> name="settingsform">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<cfoutput query = "qrySettings">
  <tr>
    <td width="30%">Email Address to send Newsletters from: </td>
    <td width="70%"><input name="nl_email" type="text" size="30" value = "#nl_email#"></td>
  </tr>
  <!---<tr>
    <td>Homepage to be directed to for newsletter: </td>
    <td><input name="nl_home" type="text" size="30" value="#nl_home#"></td>
  </tr>--->
  <tr>
    <td>Use a Specific Mail Server?*</td>
    <td><select name="nl_UseServer">
      <option value = "Yes" <cfif nl_UseServer IS 'Yes'>SELECTED</cfif>>Yes</option>
      <option value = "No" <cfif NOT nl_UseServer IS 'Yes'>SELECTED</cfif>>No</option>
    </select></td>
  </tr>
  <tr>
    <td>Outgoing Email Server to Use: </td>
    <td><input name="nl_mailserver" type="text" size="30" value = "#nl_mailserver#" /></td>
  </tr>
  <tr>
    <td>Use Mail Server Username/Password?*</td>
    <td><select name="nl_UsePassword">
		<option value = "Yes" <cfif nl_UsePassword IS 'Yes'>SELECTED</cfif>>Yes</option>
		<option value = "No" <cfif NOT nl_UsePassword IS 'Yes'>SELECTED</cfif>>No</option>
    </select>    </td>
  </tr>
  <tr>
    <td>Usnername:</td>
    <td><input name="nl_MailUsername" type="text" size="30" value = "#nl_MailUsername#" /></td>
  </tr>
  <tr>
    <td>Password:</td>
    <td><input name="nl_MailPassword" type="text" size="30" value = "#nl_MailPassword#" /></td>
  </tr>
  <tr>
    <td valign="top"><p>Blocked Domains (Seperate by Comma):</p>
      <p>If you want to block certain domains from receiving your newletter mailouts, enter them here, and seperate each one with a comma (i.e. aol.com, hotmail.com). The person will be able to signup for the newsletter but their email will be skipped over for all mailouts.</p></td>
    <td valign="top"><textarea name="nl_blockeddomains" id="nl_blockeddomains" cols="45" rows="10">#nl_blockeddomains#</textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
		<cfoutput><input name="nl_home" type="hidden" size="30" value="#request.HomeURL#"></cfoutput>
		<input type="submit" name="Submit" value="Update Settings"></td>
  </tr>
</cfoutput>
</table>
<p>* Some Coldfusion host providers require that you specify the mail server and a username/password for your outgoing email for the CFMAIL tag to work properly. You will need to check with your hosting provider as you will not get an error message if these settings are not correct. Your newsletter will simply not go out and there will be no bounceback to your email letting you know it failed. On many servers you do not need to specify a server or a username and password because the host provider may have setup a default server and username/password in the Coldfusion Administrator. If you are unsure, leave the server and username/password fields empty and set the settings to NO and see if it works that way.</p>
</form>




















