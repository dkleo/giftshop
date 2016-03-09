<!---Styles--->
<style type="text/css">
<!--
.style2 {font-size: 24px}
.style3 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<script language="javascript">
function viewme(ordernumber)
{
	var a = window.open('','','width=350,height=400,scrollbars=1');
	var elname = 'view_'+ordernumber;
	a.document.open("text/html");
	a.document.write(document.getElementById(elname).innerHTML);
	a.document.close();
}
</script>

<!---Default Values--->
<cfparam name = "viewmonth" default="#dateformat(now(), 'mm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">
<cfparam name = "affiliateid" default="None">
<cfparam name = "lastdid" default="pay">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="50">
<cfparam name = "end" default="999">
<cfparam name = "sortby" default = "affiliateid">
<cfparam name = "sortorder" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "All">
<cfparam name = "searchbox" default = "">

<cfif affiliateid IS 'None'>
<p>Error:  Must pass a valid affiliateid
  <cfabort>
  </cfif>

  <!---Figure their current balance.  
This is all the current transactions that have not been paid out yet--->
  <cfquery name = "qryTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#affiliateid#' AND paid = 'No'
  </cfquery>

  <!---If above returns zero records then set the balance to zero, otherwise add it up--->
  <cfset accountbalance = 0.00>
  <cfoutput query = "qryTransactions">
    <!---If there is a commission, then add it to the balance due--->
    <cfif len(commission) GT 0>
      <cfset accountbalance = accountbalance + #commission#>
    </cfif>
  </cfoutput>

  <!---Query the transactions for the currently selected month/year--->
  <cfquery name = "qryMonthTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#affiliateid#' 
<cfif NOT ViewMonth IS '00'>AND TransMonth = #ViewMonth#</cfif> AND TransYear = #ViewYear#
ORDER BY TransDate DESC
  </cfquery>

  <!---Get the years to display in the year box--->
  <cfquery name = "qryYears" datasource="#request.dsn#">
SELECT DISTINCT TransYear FROM afl_transactions
WHERE affiliateID = '#affiliateid#'
  </cfquery>
  
  <!---Get the Affiliate Info--->
  <cfquery name = "qryAffiliate" datasource="#request.dsn#">
	SELECT * FROM afl_affiliates
	WHERE affiliateID = '#affiliateid#'
  </cfquery>
  
</p>
<cfoutput><h2>Transaction Details for #affiliateid#</h2></cfoutput>
<cfoutput><a href="index.cfm?action=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sortorder=#sortorder#">Go Back</a></cfoutput><br />
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><table width="200" border="0" cellspacing="0" cellpadding="4">
      <!---Display the account balance (figured above)--->
      <tr>
        <td align="center" bgcolor="#0066CC"><span class="style3">Unpaid Commissions</span></td>
      </tr>
      <tr>
        <td height="35" align="center" bgcolor="#E8E8E8"><strong><span class="style2"><cfoutput>#dollarformat(accountbalance)#</cfoutput></span></strong></td>
      </tr>
    </table></td>
    <td width="30%" valign="top"><cfoutput query = "qryAffiliate">
	#CheckName#<br />
	#Address1#<br />
	#Address2#<br />
	#City#, #state#, #zip#<br />
	#Country#
	</cfoutput>	</td>
    <td width="30%" valign="top">
	<cfoutput query = "qryAffiliate">
	Phone: #phone#<br />
      Email: #email#<br />
      <br />
	  </cfoutput></td>
  </tr>
</table>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="11" valign="bottom"><form name="form1" method="post" <cfoutput>action="index.cfm?action=transactions&affiliateid=#affiliateid#&lastdid=#lastdid#"</cfoutput>>
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td width="40%"><select name="viewmonth">
            <option value="00" <cfif viewmonth IS '00'>selected</cfif>>All Months</option>
            <option value="01" <cfif viewmonth IS '01'>selected</cfif>>January</option>
            <option value="02" <cfif viewmonth IS '02'>selected</cfif>>February</option>
            <option value="03" <cfif viewmonth IS '03'>selected</cfif>>March</option>
            <option value="04" <cfif viewmonth IS '04'>selected</cfif>>April</option>
            <option value="05" <cfif viewmonth IS '05'>selected</cfif>>May</option>
            <option value="06" <cfif viewmonth IS '06'>selected</cfif>>June</option>
            <option value="07" <cfif viewmonth IS '07'>selected</cfif>>July</option>
            <option value="08" <cfif viewmonth IS '08'>selected</cfif>>August</option>
            <option value="09" <cfif viewmonth IS '09'>selected</cfif>>September</option>
            <option value="10" <cfif viewmonth IS '10'>selected</cfif>>October</option>
            <option value="11" <cfif viewmonth IS '11'>selected</cfif>>November</option>
            <option value="12" <cfif viewmonth IS '12'>selected</cfif>>December</option>
          </select>
            <select name="viewyear">
				<cfoutput query = "qryYears">
				<option SELECTED value = "#transyear#">#transyear#</option>
				</cfoutput>
				<cfif qryYears.recordcount IS 0>
					<cfoutput><option value = "#viewyear#">#viewyear#</option></cfoutput>
				</cfif>
            </select>
			<input type = "submit" name = "submitview" value="View"></td>
          <td>&nbsp;</td>
          <td><div align="right">
            <div align="right"><cfoutput><a href="index.cfm?action=transactions_insert&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Insert Transaction</a> | <a href="index.cfm?action=exporttranscsv&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Export Results to CSV</a> | <a href="index.cfm?action=exporttrans&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Export Results to XLS</a>
              </div>
              </cfoutput>
              </div></td>
        </tr>
      </table>
        </form>    </td>
  </tr>
  <tr>
    <td width="15%" align="left" bgcolor="#000000"><span class="style3">Date</span></td>
    <td align="left" bgcolor="#000000"><span class="style3">Description</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Order</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Order Status</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Sale</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Commission</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Payment</span></td>
    <td width="5%" align="left" bgcolor="#000000"><strong><font color="#FFFFFF">Paid?</font></strong></td>
    <td width="10%" align="left" bgcolor="#000000"><div align="center"><strong><font color="#FFFFFF">Check #</font></strong></div></td>
    <td width="10%" align="left" bgcolor="#000000"><div align="center"></div></td>
  </tr>
  <cfloop query = "qryMonthTransactions">
  
  <cfquery name = "qOrder" datasource="#request.dsn#">
  SELECT * FROM orders WHERE ordernumber = '#OrderNumber#'
  </cfquery>

  <cfset customerid = 0>
  
  <cfoutput query = "qOrder">
  	<cfset customerid = qOrder.customerid>
  </cfoutput>

  <cfoutput>  
  <tr>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>#dateformat(transdate, "mm/dd/yyyy")#</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>#TransDesc#</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>><a href = "##" onClick="viewme('#OrderNumber#');">#OrderNumber#</a>

    <div id="view_#ordernumber#" style="display:none;">
  	
    	<cfif qOrder.recordcount GT 0>
        	<cfinclude template = "dspDetails.cfm">
        <cfelse>
        	<h2>Invalid Order Number</h2>
            Order information about this transaction is not in the database.  Either the order was deleted or this is a reference number to a transaction that isn't in your online database.
       	</cfif>
    </div>    </td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>#OrderStatus#</td>
	<td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>
	<cfif TransType IS '0'>-<cfelse>#dollarformat(SaleAmount)#</cfif>	</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>
	<cfif TransType IS '0'>-<cfelse>#dollarformat(Commission)#</cfif></td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>>
	<cfif TransType IS '0'>#dollarformat(Payout)#<cfelse>-</cfif>	</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>><div align="center">#paid#</div></td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>><div align="center">#checknumber#</div></td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif><cfif TransType IS '2'>bgcolor="##CCCCFF"</cfif>><div align="center"><a href = "index.cfm?action=transactions_edit&transid=#transid#&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#"><img src="icons/edit.gif" width="16" height="16" border="0" /></a> &nbsp; 
    <a href = "index.cfm?action=transactions_delete&transid=#transid#&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#"><img src="icons/delete.gif" width="16" height="16" border="0" /></a></div></td>
  </tr>  
  </cfoutput>
  </cfloop>
  <cfif qryMonthTransactions.recordcount IS 0>
  <tr>
    <td colspan = "11">There are no transactions to display for the selected month/year.</td>
  </tr>
  </cfif>
</table>












