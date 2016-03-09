<style type="text/css">
<!--
.style3 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<h2>Affiliate Menu Customization <cfoutput><a href = "#request.AdminPath#helpdocs/custom_affiliate_menu_items.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></a></cfoutput></h2>

<cfquery name = "qMenu" datasource="#request.dsn#">
select * FROM afl_menu
ORDER BY ordervalue ASC
</cfquery>
<p><a href="index.cfm?action=menu_add">Insert Link</a></p>
<form name="form1" method="post" action="">
  <table width="680" border="0" cellspacing="0" cellpadding="6">
    <tr>
      <td width="30%" bgcolor="#000000"><span class="style3">Title</span></td>
      <td bgcolor="#000000"><span class="style3">Link</span></td>
      <td width="10%" bgcolor="#000000"><span class="style3">Order</span></td>
      <td width="10%" bgcolor="#000000">&nbsp;</td>
    </tr>
    <cfoutput query = "qMenu">
    <tr>
      <td>
      <input type="hidden" name="ids" id="ids" value="#id#">
      #link_title#</td>
      <td>#link_url#</td>
      <td><div align="center">
        <input name="ordervalue" type="text" id="ordervalue" size="5" value="#ordervalue#">
      </div></td>
      <td><div align="center"><a href = "index.cfm?action=menu_edit&id=#id#"><img src="icons/edit.gif" width="16" height="16" border="0"></a>&nbsp;&nbsp;<a href = "index.cfm?action=menu_delete&id=#id#"><img src="icons/delete.gif" width="16" height="16" border="0"></a></div></td>
    </tr>
    </cfoutput>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td colspan="2">
        <div align="right">
          <cfif qMenu.recordcount GT 0><input type="submit" name="button" id="button" value="Update Order">
          </cfif>
          </div></td>
      </tr>
  </table>
</form>

