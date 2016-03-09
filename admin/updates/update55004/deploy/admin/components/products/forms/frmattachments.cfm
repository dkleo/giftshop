<!---this is not done yet--->
<cfparam name = "sortoption" default = "inactive">

<cfinclude template = "../queries/qryproducts.cfm">
<cfinclude template = "../queries/qryattachments.cfm">

<h2>Downloadable Items</h2>
<p>
  <strong>Downloadable items for <font color="#0033FF"><cfoutput query = "qryProducts" maxrows="1">#ProductName# (sku: #sku# - ProductID: #productid#)</cfoutput><br />
  <font color="#000000">These are items that are downloadable only after a person orders the specific item.</font></font></strong>

<p><cfoutput><a href = "doproducts.cfm?action=uploadfiles&itemid=#qryProducts.Itemid#">Upload Attachments</a></cfoutput><br />
<table width="90%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td bgcolor="#006699"><font color="#FFFFFF"><strong>File Name</strong></font></td>
    <td width="20%" bgcolor="#006699"><font color="#FFFFFF"><strong>File Size</strong></font></td>
    <td width="10%" bgcolor="#006699"><div align="center"><font color="#FFFFFF"><strong>Delete</strong></font></div></td>
  </tr>
	<cfif qryAttachments.recordcount GT 0>
	<cfoutput query = "qryAttachments">
  <tr>
    <td>#Filename#</td>
    <td>
	<cfif filesize LT 1000000>
		<cfset fsize = filesize / 1000>#round(fsize)# KB
    </cfif>
	<cfif filesize GT 999999>
		<cfset fsize = filesize / 1000000>#round(fsize)# MB
    </cfif>
   
    </td>
    <td align="center"><a href = "doproducts.cfm?action=deletedownload&id=#id#&filename=#filename#&itemid=#url.itemid#"><img src="../../icons/delete.gif" border="0"></a></td>
  </tr>
	</cfoutput>
	<cfelse>
	<tr>
	<td colspan = "3">
		No	files have been uploaded yet.</td>
	</cfif>
</table>
<p>
















