<html>
<head>
<title>Store Admin</title>

<style>
.updatenotification_box {border: #990000 2px solid; background:#FFCCFF; text-align:center; font-weight:bold; color:#000000; font-size:12px; font-family:Arial, Helvetica, sans-serif; padding:5px;}
.updatenotification_installbox {border: #006600 2px solid; background:#CCFFFF; text-align:center; font-weight:bold; color:#000000; font-size:12px; font-family:Arial, Helvetica, sans-serif; padding:5px;}
</style>
</head>
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">

</td>
  <tr>
    <td height="15" background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
    <td width="351" style="border-top: #000000 1px solid; border-bottom: #000000 1px solid;"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td width="50"><img src="images/orders.gif" width="48" height="48"></td>
        <td><strong><font color="#000000" size="4" face="Verdana, Arial, Helvetica, sans-serif">Orders</font></strong> </td>
      </tr>
      
    </table></td>
    <td width="12" background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;">&nbsp;</td>
    <td width="15" background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
    <td width="346" style="border-top: #000000 1px solid; border-bottom: #000000 1px solid;"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td width="50"><img src="images/support.jpg" width="48" height="48" /></td>
        <td><strong><font color="#000000" size="4" face="Verdana, Arial, Helvetica, sans-serif">Support Tickets</font></strong> </td>
      </tr>
      
    </table></td>
    <td width="10" background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;">&nbsp;</td>
  </tr>
  <tr>
    <td width="14" background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
    <td valign="top" style="padding: 8px;">
	<cfinclude template = "actions/summary.cfm">	</td>
    <td width="12" background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;">&nbsp;</td>
    <td background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
    <td valign="top">
	<cfinclude template = "components/tickets/forms/frmticketssummary.cfm">	</td>
    <td background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;"></td>
  </tr>
  <tr>
    <td align="right" valign="top" style="background-position: top right;"><img src="images/sitebottomleft.gif" /></td>
    <td height="12" background="images/menushadow.gif" style="background-position:top;"><img src="images/spacer.gif" width="20" height="1" /></td>
    <td align="left" valign="top" ><img src="images/sitebottomright.gif" /></td>
    <td align="right" valign="top" ><img src="images/sitebottomleft.gif"  /></td>
    <td background="images/menushadow.gif" ><img src="images/spacer.gif" width="20" height="1" /></td>
    <td valign="top" ><img src="images/sitebottomright.gif" /></td>
  </tr>
  <tr>
	<td background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
  	<td colspan="4" style="border-top: #000000 1px solid; border-bottom: #000000 1px solid;"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td width="50"><img src="images/alerts.jpg" width="48" height="48" /></td>
        <td><strong><font color="#000000" size="4" face="Verdana, Arial, Helvetica, sans-serif">Alerts &amp; Tips </font></strong></td>
      </tr>
      
    </table></td>
	<td background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;">&nbsp;</td>
 </tr>
 <!---ALERTS--->
  <tr>
    <td background="images/leftsiteshadow.gif" style="background-position: right; background-repeat: repeat-y;">&nbsp;</td>
  	<td colspan="4"><table width="98%" border="0" align="center" cellpadding="4" cellspacing="0">
      
      <tr>
        <td height="100" align="left" valign="top"><cfinclude template = "actions/actalerts.cfm"></td>
      </tr>
    </table></td>
	<td background="images/rightsiteshadow.gif" style="background-position: left; background-repeat: repeat-y;">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top" ><img src="images/sitebottomleft.gif" /></td>
    <td height="10" colspan="4" background="images/menushadow.gif"><img src="images/spacer.gif" width="20" height="1" /></td>
    <td align="left" valign="top"><img src="images/sitebottomright.gif" /></td>
  </tr>
</table>

<style>
.updatesdiv {color: #FF0000;
font-size: 11pt;
font-weight: bold;
}
</style>

<!---automatic updates are only available for cf server version 8 and up because it uses the cfzip tag that is not included in earlier versions of CF Server--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfif request.checkforupdates IS 'Yes'>
    <div id = "updatecheckdiv" class="updatesdiv" style="padding-left: 25px;">Checking for updates...</div>
    <div id = "updatecheckdiv" class="updatesdiv_note" style="padding-left: 25px;">You currently have automatic updates on.  This will check for and download any updates available each time you visit the main page of your
    control panel.  You should click on the home link after an update to make sure there are no additional updates.  You may turn off this feature under <strong>Settings and Tools</strong> --> <strong>Store Settings</strong>.</div>
    </cfif>
    
    <cfflush>
    <cfif request.checkforupdates IS 'Yes'>
     <!---check for updates at the support url--->
     <cfinclude template = "actions/actcheckforupdates.cfm">
    </cfif>
</cfif>

<cfif qryLoginCheck.username IS 'demo'>
<div style="padding-left: 20px;">
<div style="border: 2px #FF0000 solid; padding:0px; font-size: 10pt; font-weight:bold; text-align:center;">
<div style="background:#FF0000; color: #FFFFFF; font-weight: bold; text-align: center;">Attention!</div>
<div style="padding:6px;">You are running in Demo Mode! Almost everything is disabled in demo mode.</div>
</div>
</div>
</cfif>


</body>
</html>





