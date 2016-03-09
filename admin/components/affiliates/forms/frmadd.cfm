<cfparam name = "affiliateID" default="0000000000">
<cfparam name = "GroupID" default="000">

<cfif isdefined('url.wasadded')>
	Affiliate was added<br>
</cfif>

<cfif groupid IS '000'>
<cfinclude template = "../queries/qrygroups.cfm">

<h2><b>Add Affiliate</b></h2>
<cfform name="form1" action="index.cfm?action=accounts.add" method="post">
<table width="96%" cellpadding="4" cellspacing="0">
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" ><b>Choose a group:</b></td>
  <td align="left" valign="top"><select name="groupid">
	<cfloop query="qryGroups">
		<cfoutput><option value="#groupid#">#groupname# (#groupid#)</option></cfoutput>
	</cfloop>
	</select> <cfinput type="submit" value="Select" name="submit"></td>
</tr>
</table>
</cfform>
</cfif>

<cfif NOT groupid IS '000'>

<cfinclude template = "../queries/qrycountries.cfm">
<cfinclude template = "../queries/qrystates.cfm">

<!---Get the last 7-digit accountit in the db--->
<cfquery name = "qryAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates WHERE groupid = '#groupid#' ORDER BY accountID DESC
</cfquery>

<cfset lastID = '000000'>
<cfoutput query = "qryAffiliates" maxrows="1">
	<cfset lastID = accountid>
</cfoutput>

<!---Now increment it by one--->
<cfset NewID = lastid + 1>

<TABLE width=100% border=0 align="center" cellPadding=0 cellSpacing=0>
  <TR>
    <TD width="100%" valign="top" height="112">
<cfform name="form1" action="index.cfm?action=accounts.insert" method="post">
<div align="center">
<table width="96%" cellpadding="4" cellspacing="0">
<tr>
  <td colspan="2">
    <h2><b>Add and Affiliate below: </b>    </h2></td>
</tr>
<tr>
  <td align="right" valign="top" class="bluetxtCF11" ><strong>ID referring person in this group:</strong> </td>
  <td align="left" valign="top"><select name = "SubAffiliateOf">
	<option value="0000000">None (Top Level)</option>
	<cfoutput query = "qryAffiliates">
	<option value="#affiliateID#">(#affiliateID#) #FirstName# #LastName#</option>
	</cfoutput>
	</select></td>
</tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" ><b>AffiliateID:</b></td>
  <td align="left" valign="top"><cfoutput>#groupid#</cfoutput><cfinput name="accountid" required="yes" message="You must specify a 7 digit affiliate ID for this affiliate" mask="9999999" maxlength="7" validate="noblanks" value="#NewID#">
    <br />
    (Should be unique; number here is auto generated so don't change unless you really need to change it.) </td>
</tr>
<tr><td width="35%" align="right" valign="middle" class="bluetxtCF11" >
  <strong>First Name</strong></td>
<td width="65%" align="left" valign="top">
<cfinput type="text" name="firstName" size="25" id="firstName" required="Yes" message="First Name is required!">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Last Name</strong></td>
<td align="left" valign="top">
<cfinput type="text" name="lastName" size="30" required="yes" message="Last Name is Required!">
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" style="font-weight: bold" >Birth Date: </td>
  <td align="left" valign="top">
    <cfinput name="birthdate" type="text" id="birthdate" required="yes" message="Birthdate is required!"/>
  <font color="red" size="4">*</font></td>
</tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Email Address </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="email" size="30" required="yes" message="Email address is required.">
<font color="red" size="4">*</font>
<br>
All correspondence will be sent to this email. </td>
</tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>Phone Number</strong></td>
<td align="left" valign="top">
<cfinput type="text" name="phone" size="25" require="yes" message="You must enter a phone number" mask="(999)999-9999">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="top" class="bluetxtCF11" >
  <strong>Mailing Address </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="address1" size="30" required="yes" message="You must enter an address!">
<font color="red" size="4">*</font><br>
<cfinput type="text" name="address2" size="30" required="no"></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>City </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="city" size="25" required="yes" message="Please enter a city.">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11" >
  <strong>State</strong></td>
<td align="left" valign="top">
<select name = "State">
	<cfoutput query = "qrystates"><option>#state#</option></cfoutput>
</select>
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" > <strong>Zip / Postal Code
  </strong></td>
<td align="left" valign="top">
<cfinput type="text" name="zip" size="15" required="yes" message="Please enter a zipcode">
<font color="red" size="4">*</font></td></tr>
<tr><td align="right" valign="middle" class="bluetxtCF11">
  <strong>Country</strong></td>
<td align="left" valign="top">
<select name = "country">
	<cfoutput query = "qryCountries"><option>#country#</option></cfoutput>
</select>
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" style="font-weight: bold" >Drivers
    License&nbsp; or Passport
    Number </td>
  <td align="left" valign="top"><cfinput name="pnumber" type="CustPassword" id="pnumber" />
  Not necessary for US Residents. </td>
</tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" style="font-weight: bold" > SSN / EIN</td>
  <td align="left" valign="top">
<cfinput type="text" name="taxId" size="25" required="yes" message="Please enter an SSN/EIN." mask="999-99-9999">
<font color="red" size="4">*</font>
<br>
Required of all U.S. residents. Enter your SSN / EIN.</td>
</tr>
<tr>
  <td align="right" valign="middle" ><b>Give then a CustPassword:</b> </td>
  <td valign="top"><cfinput type="text" name="CustPassword" size="25" required="yes" message="Please enter a CustPassword.">
    <font color="red" size="4">*</font></td>
</tr>
<tr><td valign="middle" ></td>
<td valign="top">
<cfoutput>
<input type="hidden" name="affiliateID" value="#affiliateID#">
<input type="hidden" name="groupID" value="#groupID#">
</cfoutput>
<input type="submit" name="Submit" value="Add Affiliate"></td></tr>
<tr><td colspan="2">
<font color="red" size="2">* Required Fields</font>
</td></tr></table>
</div>
</cfform></td>
  </tr>
</table>
</cfif>











