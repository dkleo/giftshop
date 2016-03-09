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

<h2>Credit Account Requests</h2>
<!---<p>+ <a href="index.cfm?action=new">Create Application</a></p>--->
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="10%" bgcolor="#000000"><span class="style1">Date</span></td>
    <td bgcolor="#000000"><span class="style1">Company</span></td>
    <td width="20%" bgcolor="#000000"><span class="style1">Contact</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Work Phone</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Cell Phone</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Credit Line Requested</span></td>
    <td width="3%" bgcolor="#000000"><div align="center"><strong><font color="#FFFFFF">View</font></strong></div></td>
  </tr>
  <cfoutput query = "qryPOs">
  <tr>
    <td>#dateformat(request_date, "mmm dd, yyyy")#</td>
    <td>#biz_name#</td>
    <td>#signature#</td>
    <td>#work#</td>
    <td>#cell#</td>
    <td>#creditline#</td>
    <td><div align="center"><a href="index.cfm?action=view&id=#id#"><img src="../../icons/view.jpg" border="0"></a></div></td>
  </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>




















