<h2>Insert Commission or Bonus</h2>

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

<cfsavecontent variable="yearbox">
<cfoutput> 
  <cfset TodaysDate= Now()>
  <cfset CurrentYear = #DatePart("yyyy", TodaysDate)#>
  <cfset startYear = #DatePart("yyyy", TodaysDate)#>
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
<cfset CurrentMonth = #DatePart("M", TodaysDate)#>
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
  <cfset CurrentDay = #DatePart("D", TodaysDate)#>
  <select name="TransDay">
    <cfloop Index="MyCount" From="1" To="31">
      <option value="#mycount#" <cfif CurrentDay IS MyCount>SELECTED</cfif>>#MyCount#</option>
    </cfloop>
  </select>
</cfoutput>
</cfsavecontent>

<cfquery name = "qryAffiliate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateID = '#affiliateid#'
</cfquery>

<cfif isdefined('form.transtype')>

    <cfset transdate = '#form.transmonth#/#form.transday#/#form.transyear#'>
    
    <cfquery name="addsale" datasource="#Request.DSN#">
    INSERT into afl_transactions
    (AffiliateID, TransDate, TransMonth, TransYear, TransType, TransDesc, OrderNumber, SaleAmount, Commission, paid, OrderStatus)
    Values
    ('#affiliateid#', #createodbcdate(TransDate)#, #form.TransMonth#, #form.TransYear#, #form.transtype#, '#form.transdesc#', '#Form.ordernumber#', '#form.total#', '#form.commish#', 'No', 'Completed')
    </cfquery>
    
    <font color="#006600"><strong>Affiliate Commission Added</strong></font>
</cfif>
<form name="inserttrans" <cfoutput>action="index.cfm?action=transactions_insert&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#"</cfoutput> id="inserttrans" method="post">
<table width="650" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td width="40%" valign="top">Affiliate: </td>
    <td><cfoutput>#affiliateid#<br /></cfoutput>
	<cfoutput query = "qryAffiliate">
    #CheckName#<br />
    #Address1#<br />
    #Address2#<br />
    #City#, #state#, #zip#<br />
    #Country#
    </cfoutput>    
    </td>
  </tr>
  <tr>
    <td>Tranaction Date:</td>
    <td>
    	<cfoutput>#monthbox# #daybox# #yearbox#</cfoutput>
    </td>
  </tr>
  <tr>
    <td>Transaction Type:</td>
    <td><select name="transtype" id="transtype">
    <option value="2">Bonus</option>
    <option value="1">Sale</option>
    </select>
    </td>
  </tr>
  <tr>
    <td>Short Description:</td>
    <td><input name="TransDesc" type="text" value="" size="55"></td>
  </tr>
  <tr>
    <td>Order or Reference Number:</td>
    <td><input type="text" value="" name="OrderNumber"> 
    (Optional)</td>
  </tr>
  <tr>
    <td>Sale Total</td>
    <td>$<input type="text" value="0.00" name="total"> (0.00 if NOT a sale)</td>
  </tr>
  <tr>
    <td>Commission Amount</td>
    <td>$<input type="text" value="0.00" name="commish"></td>
  </tr>
  <tr>
    <td></td>
    <td><input type="submit" value="Insert Commission" id="submitbtn" name="submitbtn"></td>
  </tr>
</table>
</form>
<p>
    <cfoutput><a href = "index.cfm?action=transactions&lastdid=#lastdid#&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sororder=#sortorder#&viewmonth=#viewmonth#&viewyear=#viewyear#">Back to Transactions</a> </p></cfoutput>
