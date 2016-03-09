<h2>Insert Commission or Bonus</h2>

<cfif isdefined('form.affiliatid')>

<cfquery name = "qAffiliate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = '#form.affiliateid#'
</cfquery>

<cfif qAffiliate.recordcount IS 0>
<font color="#FF0000"><strong>Invalid Affiliate ID</strong></font>

<cfelse>

<cfquery name="addsale" datasource="#Request.DSN#">
INSERT into afl_transactions
(AffiliateID, TransDate, TransMonth, TransYear, TransType, TransDesc, OrderNumber, SaleAmount, Commission, paid, OrderStatus)
Values
('#form.affiliateid#', '#TransDate#', #iTransMonth#, #iTransYear#, 1, 'Sale', '#Form.ordernumber#', '#total#', '#commish#', 'No', 'Pending')
</cfquery>

<font color="#006600"><strong>Affiliate Commission Added</strong></font>

</cfif>

<form name="inserttrans" action="index.cfm?action=insertcommission" id="inserttrans">
<table width="650" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td width="40%">Affiliate ID: </td>
    <td><input type="text" value="" name="affiliateid"></td>
  </tr>
  <tr>
    <td>Tranaction Date:</td>
    <td>
    
    </td>
  </tr>
  <tr>
    <td>Transaction Type:</td>
    <td><select name="transtype" id="transtype">
    <option value="1">Sale</option>
    <option value="2">Bonus</option>
    </select>
    </td>
  </tr>
  <tr>
    <td>Short Description:</td>
    <td><input name="TransDesc" type="text" value="" size="55"></td>
  </tr>
  <tr>
    <td>Order or Reference Number:</td>
    <td><input type="text" value="" name="OrderNumber"> (If this is a sale)</td>
  </tr>
  <tr>
    <td>Sale Total</td>
    <td>$<input type="text" value="" name="total"> (If this is a sale)</td>
  </tr>
  <tr>
    <td>Commission Amount</td>
    <td>$<input type="text" value="" name="commish"></td>
  </tr>
  <tr>
    <td></td>
    <td><input type="submit" value="Insert Commission" id="submitbtn" name="submitbtn"></td>
  </tr>
</table>
</form>