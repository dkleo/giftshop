<cfinclude template = "../queries/qrycontactsettings.cfm">

<h2>Contact Form Settings</h2>
<cfif isdefined('url.wasupdated')>
<font color="#FF0000"><strong>Setting were saved!</strong></font><br />
</cfif>
<cfoutput query = "qryContactSettings">
<form id="form1" name="form1" method="post" action="index.cfm?action=save_settings">
  <table width="550" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="40%">Use Default Mail Setting?</td>
      <td><select name="UseDefaultServer" id="UseDefaultServer">
        <option value="Yes" <cfif UseDefaultServer IS 'Yes'>selected="selected"</cfif>>Yes</option>
        <option value="No" <cfif UseDefaultServer IS 'No'>selected="selected"</cfif>>No</option>
      </select> <a href = "#request.AdminPath#helpdocs/contact_form_use_default_mail_settings.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a>      </td>
    </tr>
    <tr>
      <td>Send Contact Messages To:</td>
      <td><input name="emails_goto" type="text" id="emails_goto" size="35" value="#emails_goto#" /> <a href = "#request.AdminPath#helpdocs/send_contact_form_emails_to.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Use Mail Server?</td>
      <td><select name="UseMailServer" id="UseMailServer">
        <option value="Yes" <cfif UseMailServer IS 'Yes'>selected="selected"</cfif>>Yes</option>
        <option value="No" <cfif UseMailServer IS 'No'>selected="selected"</cfif>>No</option>
                  </select> <a href = "#request.AdminPath#helpdocs/mail_username_and_password.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Mail Server:</td>
      <td><input name="MailServer" type="text" id="MailServer" size="35" value="#MailServer#" /> <a href = "#request.AdminPath#helpdocs/mail_server.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Use Mail Server Login?</td>
      <td><select name="UseMailLogin" id="UseMailLogin">
        <option value="Yes" <cfif UseMailLogin IS 'Yes'>selected="selected"</cfif>>Yes</option>
        <option value="No" <cfif UseMailLogin IS 'No'>selected="selected"</cfif>>No</option>
            </select></td>
    </tr>
    <tr>
      <td>Mail Server Username:</td>
      <td><input name="mailuser" type="text" id="mailuser" size="35" value="#mailuser#" /></td>
    </tr>
    <tr>
      <td>Mail Server Password:</td>
      <td><input name="mailpassword" type="password" id="mailpassword" size="35" value="#mailpassword#" /></td>
    </tr>
   <!--- <tr>  WILL ADD TO ANOTHER UPDATE
      <td>Store Contact Data in Database?</td>
      <td><select name="select4" id="select4">
        <option value="Yes" selected="selected">Yes</option>
        <option value="No">No</option>
      </select></td>
    </tr>--->
    <tr>
      <td>Name of Thank You Page:</td>
      <td><input name="thanks_page" type="text" id="thanks_page" size="35" value="#thanks_page#" /> <a href = "#request.AdminPath#helpdocs/name_of_thank_you_page..cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Use Captcha (requires CF8)</td>
      <td><select name="usecaptcha" id="usecaptcha">
        <option value="Yes" <cfif usecaptcha IS 'Yes'>selected="selected"</cfif>>Yes</option>
        <option value="No" <cfif usecaptcha IS 'No'>selected="selected"</cfif>>No</option>
            </select> <a href = "#request.AdminPath#helpdocs/use_captcha.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Captcha Difficulty:</td>
      <td><select name="captcha_difficulty" id="captcha_difficulty">
        <option value="Low" <cfif captcha_difficulty IS 'Low'>selected="selected"</cfif>>Low</option>
        <option value="Medium" <cfif captcha_difficulty IS 'Medium'>selected="selected"</cfif>>Medium</option>
        <option value="High" <cfif captcha_difficulty IS 'High'>selected="selected"</cfif>>High</option>
        </select> <a href = "#request.AdminPath#helpdocs/captcha_difficulty.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>Custom Subject Line:</td>
      <td><input name="subject_line" type="text" id="subject_line" size="35" value="#subject_line#" /> <a href = "#request.AdminPath#helpdocs/contact_form_subject_line.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="button" id="button" value="Save Settings" /></td>
    </tr>
  </table>
</form>
</cfoutput>
<p>The link to your contact form is: <cfoutput><a href = "#request.homeurl#index.cfm?action=contactform_show" target="_blank">#request.homeurl#index.cfm?action=contactform_show</a></cfoutput></p>




















