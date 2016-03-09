<style type="text/css">
<!--
.style3 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<h2>Processor Administration</h2>

<cfif NOT qryLoginCheck.userlevel IS 'masteradmin'>
You do not have the required permissions to view this section of the control panel.
<cfabort>
</cfif>

<cfinclude template = "../queries/qryprocs.cfm">

<div style="padding: 5px;"><a href = "index.cfm?action=new">New Processor</a></div>
<table width="700" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td width="25%" bgcolor="#000000"><span class="style3">Name</span></td>
    <td bgcolor="#000000"><span class="style3">Display Name</span></td>
    <td width="10%" bgcolor="#000000"><div align="center" class="style3">
      <div align="left">Enabled</div>
    </div></td>
    <td width="10%" bgcolor="#000000"><span class="style3">Type</span></td>
    <td width="5%" bgcolor="#000000">&nbsp;</td>
  </tr>
  <cfoutput query = "qProcs">
  <tr class="normal" onmouseover="this.className = 'onhover';" onmouseout="this.className = 'normal';">
    <td>#p_name#</td>
    <td>#p_adminname#</td>
    <td><cfif #is_enabled# IS 1>Yes<cfelse>No</cfif></td>
    <td>#p_type#</td>
    <td><div align="center"><a href="index.cfm?action=edit&amp;id=#id#">Edit</a></div></td>
    </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>
