<!---Loads all the variables for the checkout form--->
<cfset ckd = "false">
<cfset ckd1 = "false">
<cfset ckd2 = "false">
<cfset ckd3 = "false">

<cfset accepts_po = 'No'>

<cfparam name = "TotalErrors" default = "0">
<cfparam name = "ErrorList" default="">
<cfparam name = "ErrorCode" default="0">

<cfif isdefined('url.TotalErrors')>
	<cfset TotalErrors = url.TotalErrors>
	<cfset ErrorMessage = url.ErrorMessage>
	<cfset ErrorList = url.ErrorList>
</cfif>

<!---Mark fields that were found to have errors--->

<cfif TotalErrors GT 0>
	<cfloop from = "1" To = "#ListLen(ErrorList)#" index="errorcount">
		<cfset ThisErrorForm = ListGetAt(ErrorList, errorcount)>
		<cfset ThisErrorForm = "msg#ThisErrorForm#">
		<cfset "#ThisErrorForm#" = "true">
	</cfloop>
</cfif>

<!---get availabe payment methods and set the default--->
<cfinclude template = "../queries/qryprocs.cfm">

<cfif qryCustomers.recordcount IS 0>
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
    <cfparam name = "payment_method" default="">
    <cfparam name = "memo" default = "">
    <cfparam name = "totalerrors" default = "0">
    <cfparam name = "errorlist" default="">
    <cfparam name = "errorcode" default="0">
    <cfparam name = "ponumber" default="">
    <cfset cust_state = "Other">
    <cfset cust_country = "United States">
    <cfset cust_shipstate = "Other">
    <cfset cust_shipcountry = "United States">
</cfif>

<cfinclude template = "../queries/qrysellingareas.cfm">

<cfif qryCustomers.recordcount GT 0>
    <cfparam name = "emailaddress" default="#qryCustomers.EmailAddress#">
    <cfparam name = "bill_firstname" default="#qryCustomers.FirstName#">
    <cfparam name = "bill_lastname" default="#qryCustomers.LastName#">
    <cfparam name = "bill_company" default="#qryCustomers.BusinessName#">
    <cfparam name = "bill_address" default="#qryCustomers.address#">
    <cfparam name = "bill_address2" default="#qryCustomers.address2#">
    <cfparam name = "bill_city" default="#qryCustomers.city#">
    <cfparam name = "bill_country" default="#qryCustomers.country#">
    <cfparam name = "bill_zip" default="#qryCustomers.zipcode#">
    <cfparam name = "bill_state" default="#qryCustomers.state#">
    <cfparam name = "ship_firstname" default="#qryCustomers.ShipFirstName#">
    <cfparam name = "ship_lastname" default="#qryCustomers.ShipLastName#">
    <cfparam name = "bill_phone" default="#qryCustomers.PhoneNumber#">
    <cfparam name = "ship_company" default="#qryCustomers.ShipbusinessName#">
    <cfparam name = "ship_address" default="#qryCustomers.ShipAddress#">
    <cfparam name = "ship_address2" default="#qryCustomers.ShipAddress2#">
    <cfparam name = "ship_city" default="#qryCustomers.ShipCity#">
    <cfparam name = "ship_state" default="#qryCustomers.ShipState#">
    <cfparam name = "ship_zip" default="#qryCustomers.ShipZip#">
    <cfparam name = "ship_country" default="#qryCustomers.ShipCountry#">
    <cfparam name = "payment_method" default="">
    <cfparam name = "totalerrors" default = "0">
    <cfparam name = "errorlist" default="">
    <cfparam name = "errorcode" default="0">
    <cfparam name = "ponumber" default="">
    <cfparam name = "custpassword" default="#qryCustomers.custpassword#">
    <cfparam name = "memo" default="">
</cfif>

<!---if they are not posting back to this form, then set the default gateway to the first one--->
<cfif NOT isdefined('form.payment_method') AND NOT isdefined('url.payment_method')>
	<cfif qGateway.recordcount GT 0>
    	<cfoutput query = "qGateway">
        	<cfset payment_method = qGateway.p_name>
         </cfoutput>
    <cfelse>
    	<cfoutput query = "q3rdparties" maxrows="1">
        	<cfset payment_method = q3rdparties.p_name>
        </cfoutput>
    </cfif>
</cfif>

<cfset cust_state = #bill_state#>
<cfset cust_country= #bill_country#>
<cfset cust_shipstate = #ship_state#>
<cfset cust_shipcountry = #ship_country#>	
  
<cfset ShipType = '#request.ShippingType#'>

<cfoutput query = "qryCustomers" maxrows="1">
	<cfset cust_state = #State#>
    <cfset cust_country = #Country#>
    <cfset cust_shipstate = #ShipState#>
    <cfset cust_shipcountry = #ShipCountry#>
</cfoutput>

<!---check that state is not abbreviated...if it is, then we need to query the states table and get the abbreviation--->
<cfquery name = "qState" datasource="#request.dsn#">
SELECT * FROM states
WHERE state = '#cust_state#'
</cfquery>

<cfif qState.recordcount GT 0>
	<cfset cust_state = qState.statecode>
</cfif>
