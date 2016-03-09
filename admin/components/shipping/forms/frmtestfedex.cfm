<cfinclude template = "../queries/qryfedexsettings.cfm">

<!---show results---->
<cfoutput query = 'qryFEDEXSettings'>
	<cfset request.Account = "#accountnumber#">
	<cfset request.metercode = "#metercode#">
</cfoutput>

<cfset Service = "ALL">

<cf_fedexxml 
	function="ServicesAvailRequest"
	fedexindentifier="#request.metercode#"
	accountnumber="#request.Account#"
	servicelevel="#Service#"
	raterequesttype="FDXE"
	shipperzip="30324"
	shipperstate="GA"
	shippercountry="US"
	shiptozip="90046"
	shiptostate="CA"
	shiptocountry="US"
	declaredvalue="500.00"
	currencycode="USD"
	packaging="YOURPACKAGING"
	ssresdelivery="1"
   	packageweight="10"
    RequestListRates="1"
    PackageWeightUnit="LBS"
	debug="true"
	>

	<p><strong>Fedex Test</strong> </p>
	<p>If you do not receive an error below, then you have successfully setup your store to work with Fedex! </p>
	<table width="250" border="0" cellpadding="1" cellspacing="0" bgcolor="#009900">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="18" colspan="2" nowrap>&nbsp;<font color="#FFFFFF" size="2" face="tahoma, verdana, sans-serif"><strong>Returned
                    Error Variables</strong></font></td>
            </tr>
            <tr>
              <td height="18" nowrap bgcolor="#FFFFFF"><font size="2" face="tahoma, verdana, sans-serif">&nbsp;<u>Rate
                  Error Number:</u></font></td>
              <td align="left" bgcolor="#FFFFFF"><font size="2" face="tahoma, verdana, sans-serif"><cfif isdefined('FedexError')><cfoutput>#FedexError#</cfoutput></cfif></font></td>
            </tr>
            <tr>
              <td height="18" nowrap bgcolor="#FFFFFF"><font size="2" face="tahoma, verdana, sans-serif">&nbsp;<u>Rate
                  Error Description:</u></font></td>
              <td align="left" nowrap bgcolor="#FFFFFF"><font size="2" face="tahoma, verdana, sans-serif"><cfif isdefined('FedexErrorDesc')><cfoutput>#FedexErrorDesc#</cfoutput></cfif></font></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
	<br>
<cfif IsDefined("qAvailServices")>
  
 
  <!--- 
  Service, Packaging, DeliveryDate, DeliveryDay, TimeInTransit, DimWeightUsed,
  OversizeCharge, RateZone, Currency, BilledWeight, DimWeight, DiscountBaseCharge, DiscountAmount, DiscountSurcharge, DiscountTotalCharge, DiscountRebateAmount,
  ListBaseCharge, ListSurcharge, ListTotalCharge, ListRebateAmount
  --->
    <table width="80%" border="0" cellpadding="0" cellspacing="0" bgcolor="#990000">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="20" colspan="2"><font color="#FFFFFF" size="2" face="tahoma, verdana, sans-serif"><strong>&nbsp;Available
                  Services Request
                  example: </strong></font></td>
          </tr>
          <cfoutput query="qAvailServices">
		  <tr>
            <td width="22%" nowrap="nowrap" bgcolor="##EEEEEE">Service
                  Level:</td>
            <td width="78%" bgcolor="##FFFFFF">&nbsp;#Service# [Packaging: #Packaging#]</td>
          </tr>
          <tr>
            <td nowrap="nowrap" bgcolor="##EEEEEE">Delivery
              Date:</td>
            <td bgcolor="##FFFFFF">#DeliveryDate# [#DeliveryDay#]</td>
          </tr>
          <tr>
            <td nowrap="nowrap" bgcolor="##EEEEEE"><font size="2" face="tahoma, verdana, sans-serif">&nbsp;<font face="Geneva, Arial, Helvetica, sans-serif">Time
                  In Transit Days:</font></font></td>
            <td bgcolor="##FFFFFF">&nbsp;<font size="2" face="Geneva, Arial, Helvetica, sans-serif">#TimeInTransit#</font></td>
          </tr>
          <tr>
            <td nowrap="nowrap" bgcolor="##EEEEEE">Amount:</td>
            <td bgcolor="##FFFFFF">#DollarFormat(DiscBaseTotalCharges)#</td>
          </tr>
          <tr>
            <td nowrap="nowrap" bgcolor="##EEEEEE">Rate
              Zone:</td>
            <td bgcolor="##FFFFFF">#RateZone#</td>
          </tr>         
          <tr>
            <td colspan="2" bgcolor="##FFFFFF" nowrap><hr size="1" noshade="noshade" /></td>
            </tr>
		  </cfoutput>
        </table></td>
      </tr>
  </table> 
</cfif>
