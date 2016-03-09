<cfparam name = "affiliateID" default="0000000000">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="50">
<cfparam name = "end" default="999">
<cfparam name = "sortby" default = "affiliateid">
<cfparam name = "sortorder" default = "ASC">
<cfparam name = "updateid" default = "0">
<cfparam name = "viewgroup" default = "All">
<cfparam name = "searchbox" default = "">

<cfinclude template = '../queries/qryaccountinfo.cfm'>
<cfinclude template = "../queries/qrygroups.cfm">
<cfinclude template = "../queries/qrycountries.cfm">
<cfinclude template = "../queries/qrystates.cfm">

<cfset SubAffiliateID = qryAccount.SubAffiliateOf>
<cfinclude template = "../queries/qrysubaffiliate.cfm">

<cfoutput query = "qryAccount">
<TABLE width=100% border=0 align="center" cellPadding=0 cellSpacing=0>
  
  <TR>
    <TD width="100%" valign="top" height="112">
<cfform name="form1" action="index.cfm?action=update" method="post">
<div align="center">
<table width="96%" cellpadding="4" cellspacing="0">
<tr>
  <td colspan="2">
    <h2><b>Edit Affiliate </b>    </h2></td>
</tr>
<tr>
  <td colspan="2" align="left" valign="middle" class="bluetxtCF11" ><table width="75%" border="0" cellpadding="4" cellspacing="0">
    <tr>
      <td width="25%"><div align="right"><!---<a href="index.cfm?action=accounts.viewsubaffiliates&affiliateid=#affiliateid#&searchbox=#searchbox#&disp=#disp#&start=#start#&viewgroup=#viewgroup#&sortby=#sortby#&sortorder=#sortorder#">View SubAffiliates</a>---> </div></td>
      <td width="25%">&nbsp;</td>
      <td width="25%">&nbsp;</td>
    </tr>
  </table></td>
  </tr>
<tr>
  <td align="right" valign="top" class="bluetxtCF11" ><strong>ID of the person that referred them:</strong> </td>
  <td align="left" valign="top"><cfif subaffiliateof IS '0'>Not a Sub Affiliate</cfif> #subaffiliateof# <cfif qrySubAffiliate.recordCount GT 0> - #qrySubAffiliate.FirstName# #qrySubAffiliate.LastName#</cfif></td>
</tr>

<tr>
  <td align="right" valign="middle" class="bluetxtCF11" style="font-weight: bold" >Affiliate Account Enabled?</td>
  <td align="left" valign="top">
  <select name="account_status" id="account_status">
    <option value="1" <cfif account_status IS '1'>selected</cfif>>Yes</option>
    <option value="0" <cfif account_status IS '0'>selected</cfif>>No</option>
  </select>
  </td>
</tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" style="font-weight: bold" >Group</td>
  <td align="left" valign="top">
        <select name="groupid" id="groupid">
        <option value="" selected="selected">No Group Assignment</option>
        <cfloop query="qrygroups">
        <option value="#qrygroups.groupid#" <cfif qryAccount.groupid IS qrygroups.groupid>selected="selected"</cfif>>#qrygroups.groupname#</option>
        </cfloop>
        </select>  </td>
</tr>
<tr><td width="35%" align="right" valign="middle" class="bluetxtCF11" >
  <strong>First Name</strong></td>
<td width="65%" align="left" valign="top">
<cfinput type="text" name="firstName" size="25" id="firstName" value="#firstname#" required="no" message="First Name is required!">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Last Name</strong></td>
<td align="left" valign="top">
<cfinput type="text" name="lastName" value="#lastName#" size="30" required="no" message="Last Name is Required!">
<font color="red" size="4">*</font></td></tr>

<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Email Address </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="email" size="30" value="#email#" required="no" message="Email address is required.">
<font color="red" size="4">*</font>
<br>
All correspondence will be sent to this email. </td>
</tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Phone Number</strong></td>
<td align="left" valign="top">
<cfinput type="text" name="phone" size="25" value="#phone#" require="yes" message="You must enter a phone number">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Mailing Address </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="address1" size="30" value="#address1#" required="no" message="You must enter an address!">
<font color="red" size="4">*</font><br>
<cfinput type="text" name="address2" size="30" value="#address2#" required="no"></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>City </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="city" size="25" value="#city#" required="no" message="Please enter a city.">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>State</strong></td>
<td align="left" valign="top">
<select name = "State">
	<cfloop query = "qrystates"><option <cfif #qrystates.state# IS #qryAccount.State#>SELECTED</cfif>>#state#</option></cfloop>
</select>
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" > <strong>Zip / Postal Code
  </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="zip" size="15" value="#zip#" required="no" message="Please enter a zipcode">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11">
  <strong>Country</strong></td>
<td align="left" valign="top">
<select name = "Country" id="Country">
	<cfloop query = "qrycountries"><option <cfif #qrycountries.country# IS #qryAccount.country#>SELECTED</cfif>>#Country#</option></cfloop>
</select>
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" ><span style="font-weight: bold">Password:</span></td>
  <td valign="top">#password#</td>
</tr>
<tr>
  <td align="right" valign="middle" ><span style="font-weight: bold">Affiliate has Sent in Their 1099 (US Tax Form):</span></td>
  <td valign="top"><input name="has1099" type="checkbox" id="has1099" value="Yes" <cfif has1099 IS 'Yes'>checked="checked"</cfif> />
    Check here if they have.</td>
</tr>

<tr>
  <td colspan="2" valign="middle" ><h2><strong>Commission Rate Override</strong></h2></td>
  </tr>
<tr>
  <td colspan="2" valign="middle" >If you would like to set a specific commission rate for this affiliate, enter the amounts that you would like to give this particular affiliate. To activate it, make sure that you set &quot;enable commission override&quot; to <em>yes</em>. Note: this will not override commission overrides on promotional codes.</td>
  </tr>
<tr>
  <td valign="middle" ><div align="right">Enable commission override?</div></td>
  <td valign="top"><select name="c_override_on" id="c_override_on">
    <option value="Yes" <cfif c_override_on IS 'Yes'>selected="selected"</cfif>>Yes</option>
    <option value="No" <cfif c_override_on IS 'No'>selected="selected"</cfif>>No</option>
  </select>  </td>
</tr>
<tr>
  <td valign="middle" ><div align="right">Override Commission Type:</div></td>
  <td valign="top"><select name="c_override_type" id="c_override_type">
    <option value="flat" <cfif c_override_type IS 'flat'>selected="selected"</cfif>>Set Dollar Amounts</option>
    <option value="percent" <cfif c_override_type IS 'percent'>selected="selected"</cfif>>Percentage</option>
  </select></td>
</tr>
<tr>
  <td valign="middle" ><div align="right">Membership Sales Level 1 Commission (direct sale):</div></td>
  <td valign="top"><input name="c_override" type="text" id="c_override" size="10" value="#c_override#" /> 
    (do not enter % or $...numbers only) </td>
</tr>
<tr>
  <td valign="middle" ><div align="right">Membership Sales Level 2 Commission (Sub Affiliates):</div></td>
  <td valign="top"><input name="c_override_2" type="text" id="c_override_2" size="10" value="#c_override_2#" />     (do not enter % or $...numbers only)</td>
</tr>
<tr>
  <td valign="middle" ><div align="right">Bizop Sales Level 1 Commission (direct sale):</div></td>
  <td valign="top"><input name="c_override_199" type="text" id="c_override_199" size="10" value="#c_override_199#" />
(do not enter % or $...numbers only) </td>
</tr>
<tr>
  <td valign="middle" ><div align="right">Bizop Sales Level 2 Commission (referrals):</div></td>
  <td valign="top"><input name="c_override_199_2" type="text" id="c_override_199_2" size="10" value="#c_override_199_2#" />
(do not enter % or $...numbers only) </td>
</tr>
<tr><td valign="middle" ></td>
<td valign="top">
<input type="hidden" name="affiliateID" value="#affiliateID#">
<input type="hidden" name="accountID" value="#accountID#">
<input type="hidden" name="disp" value="#url.disp#">
<input type="hidden" name="start" value="#url.start#">
<input type="hidden" name="searchbox" value="#url.searchbox#">
<input type="hidden" name="sortby" value="#url.sortby#">
<input type="hidden" name="sortorder" value="#url.sortorder#">
<input type="submit" name="Submit" value="Update Information"></td></tr>
<tr><td colspan="2">
<font color="red" size="2">* Required Fields</font>
</td>
<!---
</tr>
<tr>
  <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="20%" bgcolor="##000000"><span style="font-weight: bold; color: ##FFFFFF">Visitors</span></td>
      <td width="20%" align="center" bgcolor="##000000"><div align="left"><span style="font-weight: bold; color: ##FFFFFF">Sales</span></div></td>
      <td width="20%" align="center" bgcolor="##000000"><div align="left"><span style="font-weight: bold; color: ##FFFFFF">Earned To Date  </span></div></td>
      <td width="20%" align="center" bgcolor="##000000"><div align="left"><span style="font-weight: bold; color: ##FFFFFF">Paid To Date </span></div></td>
      <td width="20%" align="center" bgcolor="##000000"><div align="left"><span style="font-weight: bold; color: ##FFFFFF">Amount Due </span></div></td>
    </tr>
    <tr>
      <td>#hits#</td>
      <td>#sales#</td>
      <td>#cEarned#</td>
      <td>#cPaid#</td>
      <td><cfset PendingPayment = cEarned - cPaid>
	  #PendingPayment#</td>
    </tr>
  </table></td>
</tr>--->
</table>
</div>
</cfform></td>
  </tr>
</table>
</cfoutput>

<cfif qryAccount.recordcount IS 0>
No affiliate exists with the ID of <cfoutput>#affiliateID#</cfoutput>
</cfif>











