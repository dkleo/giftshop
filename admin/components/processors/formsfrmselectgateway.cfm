<h2>Select The Gateway You will Use</h2>

<cfinclude template = "../queries/qrygateways.cfm">

<a href="index.cfm?action=clear_gateway">Clear Gateway Setting (Use none of these)</a>
<form id="form1" name="form1" method="post" action="index.cfm?action=setgateway">
<table width="700" border="0" cellspacing="0" cellpadding="6">
  <cfoutput query = "qProcs">
  <tr class="normal" onmouseover="this.className = 'onhover';" onmouseout="this.className = 'normal';">
    <td width="20">
      <input type="radio" name="proc" id="proc#id#" value="#id#" <cfif use_this IS '1'>checked="checked"</cfif> /></td>
    <td width="522"><label for="proc#id#">#p_adminname#</label></td>
    <td width="50"><a href = "index.cfm?action=settings&id=#id#">Settings</a></td>
  </tr>
  </cfoutput>
  <tr>
    <td>&nbsp;</td>
    <td><input type = "submit" name="submitbtn" value="Select Primary Gateway" /></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>