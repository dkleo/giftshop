<h2>Edit PO Number</h2>
<cfinclude template = "../queries/qrypos.cfm">

<cfoutput query = "qryPOs">
<form method="post" action="index.cfm?action=update" name="form1">
<table width="550" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="25%">PO Number:</td>
    <td><input type="text" name="po_number" id="po_number" value="#po_number#"></td>
  </tr>
  <tr>
    <td>Company:</td>
    <td><input type="text" name="company" id="company" value="#companyname#"></td>
  </tr>
  <tr>
    <td>Contact Name:</td>
    <td><input type="text" name="contactname" id="contactname" value="#contactname#"></td>
  </tr>
  <tr>
    <td>Phone:</td>
    <td><input type="text" name="phone" id="phone" value="#phone#"></td>
  </tr>
  <tr>
    <td>File Number:</td>
    <td><input type="text" name="filenumber" id="filenumber" value="#filenumber#"></td>
  </tr>
  <tr>
    <td valign="top">Notes:</td>
    <td><textarea name="notes" id="notes" cols="40" rows="6">#notes#</textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
    <input type="hidden" name="id" value="#id#" />
    <input type="submit" name="button" id="button" value="Update PO Number"></td>
  </tr>
</table>
</form>
</cfoutput>















