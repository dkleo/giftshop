<h2>Select Third Party Processors You will Use</h2>

<cfinclude template = "../queries/qrythirdparties.cfm">

<form id="form1" name="form1" method="post" action="index.cfm?action=set3rdparty">
<table width="700" border="0" cellspacing="0" cellpadding="6">
  <cfoutput query = "qProcs">
  <tr class="normal" onmouseover="this.className = 'onhover';" onmouseout="this.className = 'normal';">
    <td width="20">
      <input type="checkbox" name="procs" id="procs#id#" value="#id#" <cfif qProcs.use_this IS 1>checked="checked"</cfif> /></td>
    <td width="572"><label for="procs#id#">#p_adminname#</label></td>
    <td width="50"><a href = "index.cfm?action=settings&id=#id#">Settings</a></td>
  </tr>
  </cfoutput>
  <tr>
    <td>&nbsp;</td>
    <td><input type = "submit" name="submitbtn" value="Select 3rd Party Processors" /></td>
    <td>&nbsp;</td>
  </tr>  
</table>
</form>