<cfinclude template = "../queries/qryupssettings.cfm">

<cfoutput query = 'qryUPSSettings'>
	<cfset request.AccessKey = "#AccessKey#">
	<cfset request.UPSUserid = "#UserName#">
	<cfset request.UPSPassword = "#Password#">
	<cfset request.UPSAccountNumber = "#AccountNumber#">
</cfoutput>

<cf_upsmx
	accesslicensenumber="#request.AccessKey#"
	userid="#request.UPSUserID#"
	Password="#request.UPSPassword#"
	requestaction="Rate"
	requestoption="Shop"
	pickuptypecode="03"		
	shipmentshipperaddresspostalcode="30324"
	shipmentshiptoaddresspostalcode="90046"
	shipmentshiptoaddresscountrycode="US"
	packagepackagingtypecode="02"
	packagedescription="Shopping cart"
	packageweight="10"
	additionalhandling="0"
	numberofpackages="1"
	mode="live"
	variable="response">
	
<cfif structKeyExists(response, 'error')> 
	<cfoutput>#response.error.errordescription# (FROM:  30324 To: 90046 (US))</cfoutput>
<cfelse>

<h2>UPS Test</h2>
If you see rate information below, then you have successfully setup the UPS real-time shipping quotes feature in your store<br />
FROM:  30324 To: 90046 (US) - 10lb package
<p>
<table width = "500" cellpadding="4" cellspacing="0">
<tr>
<td width="50%" bgcolor="#0099CC"><span style="font-weight: bold; color: #FFFFFF">Service</span></td>
<td width="50%" bgcolor="#0099CC"><span style="font-weight: bold; color: #FFFFFF">Rate</span></td>
</tr>
<cfoutput query = "response">
<tr>
<td>(#response.ServiceCode#) #response.Service#</td>
<td>#dollarformat(response.rate)#</td>
</tr>
</cfoutput>
</table>
</cfif>



