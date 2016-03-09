<cfinclude template = "../queries/qrylinks.cfm"> 
<h2>Links Widget</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><p>This section is used for editing the links that appear in the links widget (if it is visible on your website). If you do not have the widget enabled, you can do so by changing the link widget settings from the setup/Widget Settings menu.</p>
      <p><font size="2">Please choose a type of link you wish to add:</font></p>
      <p align="left"><font size="2"><a href="dolinks.cfm?action=AddSiteLink">Insert a 
        Site Link</a> <!--- This is an internal link to a page you created using the 
        control panel</font></p>--->
      <!---<p align="left"><font size="2"><a href="dolinks.cfm?action=addCustomLink">A 
        Custom Link </a>- This would be a link to an external page or other page 
        that you didn't create in the control panel.</font></p>--->
      or <a href="dolinks.cfm?action=AddCustomLink">Insert an Offsite Link</a> </td>
  </tr>
</table>
<p><b>Current Links (Click on one to edit it)</b></p>
<div align="center">
  <center>
    <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="101%" id="AutoNumber2" cellpadding="6">
      <tr> 
        <td width="12%" bgcolor="#000080"> <p align="center"><font color="#FFFFFF"><b>Order 
        Value</b></font></td>
        <td width="20%" bgcolor="#000080"> <p align="left"><font color="#FFFFFF"><b> 
        Link Name</b></font></td>
        <td width="44%" bgcolor="#000080"><font color="#FFFFFF"><b> URL</b></font></td>
        <td width="11%" bgcolor="#000080"><font color="#FFFFFF"><b> Target</b></font></td>
        <td width="14%" bgcolor="#000080" align="center"><font color="#FFFFFF"><b> 
          Delete</b></font></td>
      </tr>
      <cfoutput query = "qryLinks"> 
        <tr> 
          <td width="9%"> 
            <p align="center">#LinkOrder#</td>
          <td width="22%"> 
            <p align="left"> <a href="dolinks.cfm?action=Edit&LinkID=#LinkID#">#LinkTitle#</a></td>
          <td width="44%">#LinkRef#</td>
          <td width="11%">#LinkTarget#</td>
          <td width="14%" align="center"> 
            <a href="dolinks.cfm?action=delete&LinkID=#LinkID#">Delete</a></td>
        </tr>
      </cfoutput> 
    </table>
  </center>
</div>



















