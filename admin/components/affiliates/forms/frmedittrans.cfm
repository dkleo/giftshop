<h2>Edit a Transaction</h2>

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
<cfparam name = "transid" default="0">

<cfquery name = "qryAffiliate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateID = '#affiliateid#'
</cfquery>

<cfquery name = "qryTransaction" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE transid = #transid#
</cfquery>

<cfif isdefined('form.transtype')>

	<cfset transdate = '#form.transmonth#/#form.transday#/#form.transyear#'>
    
    <cfquery name="addsale" datasource="#Request.DSN#">
    UPDATE afl_transactions
    SET AffiliateID='#form.affiliateid#', 
    TransDate=#createodbcdate(TransDate)#, 
    TransMonth=#form.TransMonth#, 
    TransYear=#form.TransYear#, 
    TransType=#form.transtype#, 
    TransDesc='#form.transdesc#', 
    OrderNumber='#form.ordernumber#', 
    SaleAmount=#form.total#,
    PayOut=#form.payout#,
    Commission=#form.commish#,
    checknumber=#form.checknumber#,
    OrderStatus='#form.orderstatus#'
    WHERE transid = #transid#
    </cfquery>
    
    <cflocation url = "index.cfm?action=transactions&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">
    
</cfif>


<cfloop query = "qryTransaction">

<cfsavecontent variable="yearbox">
<cfoutput> 
  <cfset TodaysDate= Now()>
  <cfset CurrentYear = #qryTransaction.transyear#>
  <cfset startYear = #qryTransaction.transyear#>
  <cfset startYear = startYear - 5>
  <cfset yearvalue = startyear>
  <select name="TransYear">
    <cfloop Index="MyCount" From="1" to="10">
      <option value="#YearValue#" <cfif #YearValue# IS #CurrentYear#>SELECTED</cfif>>#yearvalue#</option>
      <cfset YearValue = YearValue + 1>
    </cfloop>
  </select>
</cfoutput>
</cfsavecontent>

<cfsavecontent variable="monthbox">
<cfset CurrentMonth = #qryTransaction.transmonth#>
<select name="TransMonth">
  <option value="01" <CFIF CurrentMonth IS '01'>SELECTED</cfif>>January</option>
  <option value="02" <CFIF CurrentMonth IS '02'>SELECTED</cfif>>February</option>
  <option value="03" <CFIF CurrentMonth IS '03'>SELECTED</cfif>>March</option>
  <option value="04" <CFIF CurrentMonth IS '04'>SELECTED</cfif>>April</option>
  <option value="05" <CFIF CurrentMonth IS '05'>SELECTED</cfif>>May</option>
  <option value="06" <CFIF CurrentMonth IS '06'>SELECTED</cfif>>June</option>
  <option value="07" <CFIF CurrentMonth IS '07'>SELECTED</cfif>>July</option>
  <option value="08" <CFIF CurrentMonth IS '08'>SELECTED</cfif>>August</option>
  <option value="09" <CFIF CurrentMonth IS '09'>SELECTED</cfif>>September</option>
  <option value="10" <CFIF CurrentMonth IS '10'>SELECTED</cfif>>October</option>
  <option value="11" <CFIF CurrentMonth IS '11'>SELECTED</cfif>>November</option>
  <option value="12" <CFIF CurrentMonth IS '12'>SELECTED</cfif>>December</option>
</select>
</cfsavecontent>

<cfsavecontent variable="daybox">
<cfoutput> 
  <cfset CurrentDay = #DatePart("D", qryTransaction.transdate)#>
  <select name="TransDay">
    <cfloop Index="MyCount" From="1" To="31">
      <option value="#mycount#" <cfif CurrentDay IS MyCount>SELECTED</cfif>>#MyCount#</option>
    </cfloop>
  </select>
</cfoutput>
</cfsavecontent>

<form name="updatetrans" <cfoutput>action="index.cfm?action=transactions_edit&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#"</cfoutput> id="updatetrans" method="post">
<table width="650" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td width="40%" valign="top">Affiliate: </td>
    <td><cfoutput><input type="hidden" value="#affiliateid#" name="affiliateid">#affiliateid#<br /></cfoutput>
	<cfoutput query = "qryAffiliate">
    #CheckName#<br />
    #Address1#<br />
    #Address2#<br />
    #City#, #state#, #zip#<br />
    #Country#    </cfoutput>    </td>
  </tr>
  <tr>
    <td>Tranaction Date:</td>
    <td>
    	<cfoutput>#monthbox# #daybox# #yearbox#</cfoutput>    </td>
  </tr>
  <tr>
    <td>Transaction Type:</td>
    <td><select name="transtype" id="transtype">
    <option value="2" <cfif transtype IS 2>selected</cfif>>Bonus</option>
    <option value="1" <cfif transtype IS 1>selected</cfif>>Sale</option>
    <option value="0" <cfif transtype IS 0>selected</cfif>>Payout</option>
    </select>    </td>
  </tr>
  <tr>
    <td>Short Description:</td>
    <td><cfoutput><input name="TransDesc" type="text" value="#transdesc#" size="55"></cfoutput></td>
  </tr>
  <tr>
    <td>Order or Reference Number:</td>
    <td><cfoutput><input type="text" value="#ordernumber#" name="OrderNumber"></cfoutput>
    (If Applicable)</td>
  </tr>
  <tr>
    <td>Sale Total (If Sale):</td>
    <td>$<cfoutput><input type="text" value="#SaleAmount#" name="total"></cfoutput> (If Applicable)</td>
  </tr>
  <tr>
    <td>Commission Amount:</td>
    <td>$<cfoutput><input type="text" value="#Commission#" name="commish"></cfoutput></td>
  </tr>
  <tr>
    <td>Payout Amount (If Payout):</td>
    <td>$<cfoutput><input type="text" value="#payout#" name="payout"></cfoutput></td>
  </tr>
  <tr>
    <td>Check Number (IF Payout):</td>
    <td><cfoutput><input type="text" value="#checknumber#" name="checknumber"></cfoutput></td>
  </tr>
  <tr>
    <td>Order Status (If Sale):</td>
    <td><cfoutput><input type="text" value="#orderstatus#" name="orderstatus"></cfoutput></td>
  </tr>
  <tr>
    <td></td>
    <td>
    <cfoutput><input type = "hidden" name="transid" value="#transid#" id="transid" /></cfoutput>
    <input type="submit" value="Update Transaction" id="submitbtn" name="submitbtn"></td>
  </tr>
</table>
</form>

</cfloop>