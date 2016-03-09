<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

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
  
<cfsavecontent variable = "xlsfile">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
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
	  TaxID: #taxid#<br />
	  </cfoutput></td>
  </tr>
</table>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="10" valign="bottom">
    
    Report for: 
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td width="40%">
		    <cfif viewmonth IS '00'>All Months</cfif>
            <cfif viewmonth IS '01'>January</cfif>
            <cfif viewmonth IS '02'>February</cfif>
            <cfif viewmonth IS '03'>March</cfif>
            <cfif viewmonth IS '04'>April</cfif>
            <cfif viewmonth IS '05'>May</cfif>
            <cfif viewmonth IS '06'>June</cfif>
            <cfif viewmonth IS '07'>July</cfif>
            <cfif viewmonth IS '08'>August</cfif>
            <cfif viewmonth IS '09'>September</cfif>
            <cfif viewmonth IS '10'>October</cfif>
            <cfif viewmonth IS '11'>November</cfif>
            <cfif viewmonth IS '12'>December</cfif>
            &nbsp;
            <cfoutput>#viewyear#</cfoutput>
			</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr>
    <td width="15%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Date</font></span></td>
    <td align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Description</font></span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Order</font></span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Order Status</font></span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Sale</font></span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Commission</font></span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3"><font color="#FFFFFF">Payment</font></span></td>
    <td width="5%" align="left" bgcolor="#000000"><strong><font color="#FFFFFF">Paid?</font></strong></td>
    <td width="10%" align="left" bgcolor="#000000"><div align="center"><strong><font color="#FFFFFF">Check #</font></strong></div></td>
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
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>#dateformat(transdate, "mm/dd/yyyy")#</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>#TransDesc#</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>#OrderNumber#   
    </td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>#OrderStatus#</td>
	<td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS '0'>-<cfelse>#dollarformat(SaleAmount)#</cfif>	</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS '0'>-<cfelse>#dollarformat(Commission)#</cfif></td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS '0'>#dollarformat(Payout)#<cfelse>-</cfif>	</td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>><div align="center">#paid#</div></td>
    <td <cfif TransType IS '0'>bgcolor="##DDFBD9"</cfif>><div align="center">#checknumber#</div></td>
  </tr>  
  </cfoutput>
  </cfloop>
  <cfif qryMonthTransactions.recordcount IS 0>
  <tr>
    <td colspan = "10">There are no transactions to display for the selected month/year.</td>
  </tr>
  </cfif>
</table>
</cfsavecontent>


<cffile action="write" addnewline="yes" output="#xlsfile#" file="#request.catalogpath#admin#request.bslash#affiliatepayments#request.bslash##affiliateid#-#viewmonth##viewYear#.xls">

<h2>Transaction Export</h2>
The report has been created and is ready to download.
<p>
<cfoutput><a href = "#request.homeurl#admin/affiliatepayments/#affiliateid#-#viewmonth##viewyear#.xls">Click here to download it</a>

<p>
<a href = "index.cfm?action=transactions&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Go back</a>
</p>
</cfoutput>












