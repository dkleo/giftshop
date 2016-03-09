<cfparam name = "emailaddress" default="">
<cfparam name = "bill_firstname" default="">
<cfparam name = "bill_lastname" default="">
<cfparam name = "bill_company" default="">
<cfparam name = "bill_address" default="">
<cfparam name = "bill_address2" default="">
<cfparam name = "bill_city" default="">
<cfparam name = "bill_country" default="">
<cfparam name = "bill_zip" default="">
<cfparam name = "bill_state" default="">
<cfparam name = "ship_firstname" default="">
<cfparam name = "ship_lastname" default="">
<cfparam name = "bill_phone" default="">
<cfparam name = "ship_company" default="">
<cfparam name = "ship_address" default="">
<cfparam name = "ship_address2" default="">
<cfparam name = "ship_city" default="">
<cfparam name = "ship_state" default="">
<cfparam name = "ship_zip" default="">
<cfparam name = "ship_country" default="">
<cfparam name = "payment_method" default="CreditCard">
<cfparam name = "memo" default = "">
<cfparam name = "totalerrors" default = "0">
<cfparam name = "errorlist" default="">
<cfparam name = "errorcode" default="0">
<cfparam name = "po_number" default="">
<cfparam name = "ordernumber" default="">
<cfparam name = "customerid" default="">
<cfparam name="FigureShipping" default="Yes">
<cfparam name="FigureTaxes" default="Yes">
<cfparam name="ipaddress" default="N/A">
<cfparam name ="processpage" default="Yes">

<cfif NOT isdefined('askforshipping')>
	<cfset askforshipping = 'Yes'>
</cfif>

<cfif askforshipping IS 'No'>
	<cfset shipmethodused = 0>
</cfif>

<cfif TotalErrors GT 0>
	<cfloop from = "1" To = "#ListLen(ErrorList)#" index="errorcount">
		<cfset ThisErrorForm = ListGetAt(ErrorList, errorcount)>
		<cfset ThisErrorForm = "msg#ThisErrorForm#">
		<cfset "#ThisErrorForm#" = "true">
	</cfloop>
</cfif>

<cfinclude template="../actions/actduplicateordercheck.cfm">

<cfif processpage IS 'Yes'>

    <cfinclude template = "../actions/actpaymentmethodvars.cfm">
    <cfinclude template = "../queries/qrysellingareas.cfm">
    <cfinclude template = "frmorder.cfm">
    <cfinclude template = "../actions/actinsertcustomer.cfm">
    <cfinclude template = "../actions/actinsertorder.cfm">
    
    <h2>Order Confirmation and Payment</h2>
    <cfif TotalErrors GT 0>
        <!--- Errors were found so mark them with javascript then show the errors--->
    
        <div class="checkout_errorsection">	
        <div class="checkout_errortitle">Please correct the following before proceeding with your order:</div>
        <div class="checkout_errormessage"><cfoutput>#ErrorMessage#</cfoutput></div>
        </div>
   
    </cfif>
    
    <!---Determine the full name of the country--->
    <cfset ShipCountryName = "">
    <cfset BillCountryName = "">
    
    <cfquery name = "qryBillCountry" datasource="#request.dsn#">
    SELECT * FROM countries
    WHERE countrycode = '#bill_country#'
    </cfquery>
    
    <cfquery name = "qryShipCountry" datasource="#request.dsn#">
    SELECT * FROM countries
    WHERE countrycode = '#ship_country#'
    </cfquery>
    
    <cfoutput query = "qryBillCountry">
        <cfset BillCountryName = #country#>
    </cfoutput>
    
    <cfoutput query = "qryShipCountry">
        <cfset ShipCountryName = #country#>
    </cfoutput>
    
    <cfinclude template = "frmshippingupdate.cfm">
    <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0" class="revieworder_addresstable">
      <tr>
        <td height="15" align="left" Class="TableTitles"><strong>Billing Information</strong></td>
        <cfif askforshipping IS 'Yes'>
        <td width="50%" height="15" align="left" valign="top" Class="TableTitles"><strong>Ship Order To:</strong></td>
		</cfif>
      </tr>
      <tr> 
        <td height="15" align="left" class="revieworder_billingaddress"><cfoutput>#bill_firstname# #bill_lastname#<br>
            <cfif NOT len(bill_company) IS 0>#bill_company#<br></cfif>
            #bill_address#<br>
            <cfif len(bill_address2) GT 0>#bill_address2#<br /></cfif>
            #bill_city#, 
            <cfif NOT bill_state IS 'Other'>
              #bill_state# 
            </cfif>
            <cfif bill_state IS 'Other'>
              #form.bill_otherstate# 
            </cfif>
            #bill_zip#<br>
              <cfif NOT BillCountryName IS ''>#BillCountryName#<cfelse>#form.bill_country#</cfif><br>
            </p>
            <p><b>Email Address:</b> #emailaddress#<br>
              <b> Phone Number:</b> #bill_phone# <br>
            </p>
            <p>&nbsp; </p>
        </cfoutput></td>
        <cfif askforshipping IS 'Yes'>
        <td width="50%" height="15" align="left" valign="top" class="revieworder_shippingaddress"><cfoutput> #ship_firstname# #ship_lastname#<br>
            <cfif NOT len(ship_company) IS 0>#ship_company#<br /></cfif>
            #ship_address#<br>
            <cfif len(ship_address2) GT 0>#ship_address2#<br /></cfif>
            #ship_city#, 
            <cfif NOT ship_state IS 'Other'>
              #ship_state# 
            </cfif>
            <cfif ship_state IS 'Other'>
              #ship_otherstate# 
            </cfif>
            &nbsp;&nbsp; #ship_zip#<br>
        <cfif NOT ShipCountryName IS ''>#ShipCountryName#<cfelse>#ship_country#</cfif></cfoutput></td>
        </cfif>
      </tr>
    </table>
	<br />&nbsp;<br />
    <cfinclude template = "frmpaymentbutton.cfm">
</cfif>
