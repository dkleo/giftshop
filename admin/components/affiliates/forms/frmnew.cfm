<h2>New Message</h2>
<cfinclude template = "../queries/qrygroups.cfm">

<cfquery name = "qryAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates ORDER BY lastname ASC
</cfquery>

<form name="form1" method="post" action="index.cfm?action=messages.send">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr> 
      <td width="19%" height="25" valign="top"><strong>Send to:</strong><br></td>
      <td width="81%" height="25">
	  	<p>
	  	  <input type="radio" name="sendto" id="sendto" value="agroup" checked="checked" />
	  	  Affiliate Group: 
	  	  <select name="ToField" size="1" id="ToField">
	  	    <option value = "All">All Affiliates</option>
	  	    <cfoutput query = "qryGroups">
	  	      <option value = "#groupid#">#groupname#</option>
  	        </cfoutput>
  	      </select>
	  	</p>
	  	<p>
	  	  <input type="radio" name="sendto" id="sendto" value="affiliate" /> 
	  	  Specific Affiliate: 
          <select name="ToField2" size="1" id="ToField2">
            <cfoutput query = "qryAffiliates">
              <option value = "#affiliateid#">#lastname#, #firstname# (#affiliateid#)</option>
            </cfoutput>
          </select>
	  	</p></td>
    </tr>
    <tr>
      <td height="26">&nbsp;</td>
      <td height="26">&nbsp;</td>
    </tr>
    <tr> 
      <td height="26"><strong>Subject:</strong></td>
      <td height="26"><input name="Subject" type="text" id="Subject" size="30" maxlength="250"></td>
    </tr>
    <tr> 
      <td height="25" valign="top"><strong>Message:</strong></td>
      <td height="25"><textarea name="body" cols="40" rows="15" id="body"></textarea></td>
    </tr>
    <tr> 
      <td height="25">&nbsp;</td>
      <td height="25"><input type="submit" name="Submit" value="Send"></td>
    </tr>
    <tr> 
      <td height="25">&nbsp;</td>
      <td height="25">&nbsp;</td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>