<!---default the viewmonth and year to the current...step back one month if viewmonth is not found--->
<cfparam name = "viewmonth" default="#dateformat(now(), 'm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">
<cfparam name = "taxinfo" default="Yes">

<cfif NOT isdefined('form.viewmonth') AND NOT isdefined('url.viewmonth')>
	<cfset viewmonth = viewmonth - 1>
    
    <cfif viewmonth LT 1>
    	<cfset viewmonth = 12>
    </cfif>


</cfif>

<!---Get the years to display in the year box--->
<cfquery name = "qryYears" datasource="#request.dsn#">
SELECT DISTINCT TransYear FROM afl_transactions
WHERE paid = 'No'
</cfquery>

<!---Select just the ones that need to be paid (have a balance)--->
<cfinclude template = "../queries/qrytopay.cfm">

<!---Find the last check number they used...if there isn't one then just default it to 1001--->
<cfset StartCheck = 1000>

<cfquery name = "qryLastCheck" datasource="#request.dsn#">
SELECT CheckNumber FROM afl_transactions
ORDER BY CheckNumber DESC
</cfquery>

<cfoutput query = "qryLastCheck" maxrows="1">
	<cfif isnumeric(checknumber)>
		<cfset StartCheck = #checknumber# + 1>
  </cfif>
</cfoutput>

<cfset nextcheck = startcheck>
<h2>Pay Affiliates</h2>
<p><strong>Important</strong>: If an affiliate balance is low and you do not wish to issue a check, please enter 0 as the check number (DO NOT leave it blank). The affiliate account will remain unpaid. </p>
<p>&nbsp;</p>
<form name="form1" method="post" <cfoutput>action="index.cfm?action=pay"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="40%"><select name="viewmonth">
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
            <option selected="selected" value = "#transyear#">#transyear#</option>
          </cfoutput>
          <cfif qryYears.recordcount IS 0>
            <cfoutput>
              <option value = "#viewyear#">#viewyear#</option>
            </cfoutput>
          </cfif>
        </select>
and 
<select name="taxinfo" id="taxinfo">
<option value="Yes" <cfif taxinfo IS 'Yes'>selected="selected"</cfif>>submitted a tax form</option>
<option value="No" <cfif taxinfo IS 'No'>selected="selected"</cfif>>have NOT submitted a tax form</option>
</select>       
<input type = "submit" name = "submitview" value="Select Month and Year" /></td>
    <td>&nbsp;</td>
    <td><div align="right"><a href="index.cfm?action=payouts">View Past Payouts</a></div></td>
  </tr>
</table>
</form>
<form method = "post" name = "PayForm" <cfoutput>action="index.cfm?action=gopay&viewmonth=#viewmonth#&viewyear=#viewyear#"</cfoutput>>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="25%" bgcolor="#0066CC" align="left"><strong><font color="#FFFFFF">Name</font></strong></td>
    <td width="25%" bgcolor="#0066CC" align="left"><strong><font color="#FFFFFF">Email Address </font></strong></td>
    <td width="5%" align="center" bgcolor="#0066CC"><font color="#FFFFFF"><b>Due</b></font></td>
    <td width="15%" bgcolor="#0066CC" align="left"><b><font color="#FFFFFF">Affiliate ID</font></b></td>
    <td width="25%" bgcolor="#0066CC" align="right"><strong><font color="#FFFFFF">Check Number</font></strong>  </td>
  </tr>
<cfif qryToPay.recordcount GT 0>
<cfloop query = "qryToPay">
<cfoutput>
  <tr>
    <td align="left">#firstname# #lastname#</td>
    <td width="25%" align="left">#email#</td>
    <td width="15%" align="center"><font color="##FF0000"><b>#LSCurrencyFormat(cPending)#</b></font></td>
    <td width="15%" align="left"><a href = "index.cfm?action=transactions&affiliateid=#affiliateid#&lastdid=pay&viewmonth=#viewmonth#&viewyear=#viewyear#">#affiliateid#</a></td>
    <cfset nextcheck = nextcheck + 1>
	<td width="25%" align="right">
	<input type="hidden" value="#cPending#" name="PaymentAmount" />
    <input type = "hidden" value="#affiliateid#" name = "affiliates" />
	<input type = "text" name = "checknumber" value="#NextCheck#" /> </td>
  </tr>
</cfoutput>
</cfloop>
<tr>
	<td colspan = "6" align="right">
	 <input type = "submit" name="payaffiliates" value="Pay Affiliates">	</td>
</tr>
<cfelse>
<tr>
	<td colspan = "6">
<b>You do not need to pay any affiliates for the currently selectd month.</b>	</td>
</tr>
</cfif>
</table>
</form>











