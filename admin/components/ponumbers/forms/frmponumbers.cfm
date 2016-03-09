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

<h2>PO Numbers</h2>
<p>+ <a href="index.cfm?action=new">Add New</a></p>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="10%" bgcolor="#000000"><span class="style1">Issued On</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">PO Number</span></td>
    <td bgcolor="#000000"><span class="style1">Company</span></td>
    <td width="12%" bgcolor="#000000"><span class="style1">Contact</span></td>
    <td width="12%" bgcolor="#000000"><span class="style1">Phone</span></td>
    <td width="10%" bgcolor="#000000"><span class="style1">File No.</span></td>
    <td width="10%" bgcolor="#000000"><span class="style1">Date Used</span></td>
    <td width="15%" bgcolor="#000000"><span class="style1">Order Number</span></td>
    <td width="3%" bgcolor="#000000"><span class="style2"></span></td>
  </tr>
  <cfoutput query = "qryPOs">
  <tr>
    <td>#dateformat(dateissued, "mmm dd, yyyy")#</td>
    <td><a href = "index.cfm?action=edit&id=#id#">#po_number#</a></td>
    <td>#companyname#</td>
    <td>#contactname#</td>
    <td>#phone#</td>
    <td>#filenumber#</td>
    <td><cfif len(ordernumber) IS 0>Not Used yet<cfelse>#dateformat(dateused, "mmm dd, yyyy")#</cfif></td>
    <td><cfif len(ordernumber) IS 0>Not Used Yet<cfelse>#OrderNumber#</cfif></td>
    <td><div align="center"><a href="index.cfm?action=delete&id=#id#"><img src="../../icons/delete.gif" border="0"></a></div></td>
  </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>
















