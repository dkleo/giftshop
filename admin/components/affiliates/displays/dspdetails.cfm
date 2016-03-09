<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<cfquery name = "qryCustomers" datasource="#Request.dsn#">
SELECT * FROm customerhistory WHERE customerid = '#customerid#'
</cfquery>

<cfoutput>
<cfset PayMethod= ''>

<table width="300" border="0" align="center" cellpadding="4" cellspacing="0">
<tr>
<td><span style="font-size: 18px; font-weight: bold">Order Number </span><span style="font-size: 18px">#OrderNumber#</span></td>
<!---Payment Method--->
<td>
  <div align="right" style="font-weight: bold; font-size: 16px"></div></td>
</tr>
<cfif paid IS 'No'>
</cfif>
</table>
</cfoutput>

<table width="300" align="center" cellpadding="4" cellspacing="0" style="border:#000000 solid 1px;">
      <tr>
        <td height="15" bgcolor="#000000" Class="TableTitles"><span class="style1">Details</span></td>
      </tr>
      <tr>
        <td height="15">
		<cfoutput query = "qryCustomers">
		<cfif len(Businessname) GT 0>#BusinessName#<br /></cfif>
		#FirstName# #LastName#<br> 
		#address#<br> 
		<cfif len(address2) GT 0>
			#address2#<br />
		</cfif>
		#city#, #State# &nbsp;&nbsp; #ZipCode#
		<br> #Country#
		<p> 
		<b>Email Address:</b> #EmailAddress#<br>
        <b> Phone Number:</b> #PhoneNumber# <br>
 	    </td>
      </tr>
	</cfoutput>
</table>

<table width="300" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td>
	<cfquery name="qryAffReferral" datasource="#request.dsn#">
	SELECT * FROM afl_transactions WHERE OrderNumber = '#OrderNumber#' AND AffiliateID = '#affiliateid#' 
	</cfquery>

	<cfif qryAffReferral.recordcount GT 0>
		<cfquery name="qryAffInfo" datasource="#request.dsn#">
		SELECT * FROM afl_affiliates WHERE affiliateid = '#qryAffReferral.affiliateid#'
		</cfquery>

		<cfoutput query = "qryAffInfo">
		<table width="300" style="border:1px ##000000 solid">
		<tr>
		  <td bgcolor="##000000"><span style="color: ##FFFFFF; font-weight: bold">Affiliate who Referred Customer</span></td>
		</tr>
		<tr>
		<td><br />
		#FirstName# #LastName#<br />
		#Address1#<br />
		<cfif len(address2) GT 0>#address2#<br /></cfif>
		#city#, #state#  #zip#<br />
		#country#</td>
		</tr>
		</table>
		</cfoutput>
        
        <center><a href = "##" onclick="window.close();">Close Window</a></center>
        
	</cfif>
	</td>
  </tr>
</table>








