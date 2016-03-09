<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
.style2 {color: #FFFFFF}
-->
</style>

<cfinclude template = "../queries/qrypos.cfm">

<h2>Purchasing Accounts</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="10%" bgcolor="#000000"><span class="style1">Issued On</span></td>
    <td bgcolor="#000000"><span class="style1">Company</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Contact</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Phone</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Account Number</span></td>
    <td width="10%" bgcolor="#000000"><span class="style1">Credit Line</span></td>
    <td width="3%" bgcolor="#000000"><span class="style2"></span></td>
  </tr>
  <cfoutput query = "qryPOs">
  <tr>
    <td>#dateformat(dateissued, "mmm dd, yyyy")#</td>
    <td>biz_name#</td>
    <td>#contactname#</td>
    <td>#phone#</td>
    <td>#account_number#</td>
    <td>#amount#</td>
    <td><div align="center"><a href="index.cfm?action=view&amp;id=#id#"><img src="../../icons/view.jpg" border="0"></a></div></td>
  </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>




















