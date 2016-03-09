<cfif NOT isdefined('form.bill_lastname')>
	<cflocation url = 'index.cfm?action=checkout&carttoken=#carttoken#'>
</cfif>

<!---Validates the information entered into the checkout form--->
<cfset URLString = '?action=checkout'>

<CFLOOP COLLECTION="#Form#" ITEM="VarName">
  <cfset URLString = '#URLString#&#VarName#=#evaluate(varname)#'>
</CFLOOP>

<cfset ErrorMessage = ''>
<cfset TotalErrors = 0>
<cfset ErrorList = ''>

<!---Billing fields--->
<cfif Len(form.bill_lastname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_lastname')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a last name for the billing address<br>'>
</cfif>

<cfif Len(form.bill_firstname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_firstname')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a first name for the billing address<br>'>
</cfif>

<cfif Len(form.bill_address) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_address')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a billing address<br>'>
</cfif>

<cfif Len(form.bill_address) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_city')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a city for the billing address<br>'>
</cfif>

<cfif Len(form.bill_address) GT 0 AND Len(form.bill_address) LT 5>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_address')>
	<cfset ErrorMessage = ErrorMessage & '-> Billing Address must be at least 5 characters<br>'>
</cfif>

<cfif form.bill_state IS 'N-A'>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'bill_state')>
	<cfset ErrorMessage = ErrorMessage & '-> Please select a state/province for billing info.<br>'>
</cfif>

<!---Shipping Fields--->
<cfif form.askforshipping IS 'yes'>
	<cfif Len(form.ship_lastname) IS 0>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_lastname')>
        <cfset ErrorMessage = ErrorMessage & '-> Please enter a last name for the shipping address<br>'>
    </cfif>
    
    <cfif Len(form.ship_firstname) IS 0>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_firstname')>
        <cfset ErrorMessage = ErrorMessage & '-> Please enter a first name for the shipping address<br>'>
    </cfif>
    
    <cfif Len(form.ship_address) IS 0>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_address')>
        <cfset ErrorMessage = ErrorMessage & '-> Please enter an address to ship this order to<br>'>
    </cfif>
    
    <cfif Len(form.ship_address) GT 0 AND Len(form.ship_address) LT 5>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_address')>
        <cfset ErrorMessage = ErrorMessage & '-> Shipping Address must be at least 5 characters<br>'>
    </cfif>
    
    <cfif Len(form.ship_city) IS 0>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_city')>
        <cfset ErrorMessage = ErrorMessage & '-> Please enter a city for the shipping address<br>'>
    </cfif>
    
    <cfif form.ship_state IS 'N-A'>
        <cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList,'ship_state')>
        <cfset ErrorMessage = ErrorMessage & '-> Please select a state/province to ship this order to.<br>'>
    </cfif>

	<cfset shiptozip = replace(form.ship_zip, " ", "", "ALL")>
    <cfset shiptozip = replace(shiptozip, "-", "", "ALL")>

	<cfif form.ship_country IS 'US'>
        <cfif NOT isnumeric(shiptozip)>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'ship_zip')>
            <cfset ErrorMessage = ErrorMessage & '-> The Zip Code is not a valid.  If you are not in the United States, please select your country.<br>'>	
        </cfif>
    </cfif>
    
    <cfif form.ship_country IS 'US'>
        <cfif len(form.ship_zip) LT 5 OR len(form.ship_zip) GT 5>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'ship_zip')>
            <cfset ErrorMessage = ErrorMessage & '-> The Zip Code is not valid for the US.  All US Zip Codes must be 5 digits and contain no spaces or letters.<br>'>
        </cfif>
    </cfif>
</cfif>


<!---Password--->
<cfif isdefined('form.CustPassword')>
	<cfif NOT form.CustPassword IS form.confirmpassword>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList, 'Password')>
		<cfset ErrorMessage = ErrorMessage & '-> The confirm Password field and Password field did not match.<br>'>
	</cfif>
	
	<cfif form.CustPassword IS ''>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList, 'Password')>
		<cfset ErrorMessage = ErrorMessage & '-> The Password field is blank.<br>'>
	</cfif>
	
	<cfif form.confirmpassword IS ''>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList, 'Password')>
		<cfset ErrorMessage = ErrorMessage & '-> Please retype your Password in the confim Password field.<br>'>
	</cfif>
</cfif>

<!---email address--->
<cfif isdefined('form.emailaddress')>
	<cfif form.emailaddress IS ''>
		<cfset TotalErrors = TotalErrors + 1>
        <cfset ErrorList = ListAppend(ErrorList, 'EmailAddress')>
        <cfset ErrorMessage = ErrorMessage & '-> Please enter a valid email address.  This will be used for your login.<br>'>
	</cfif>
</cfif>

<cfif NOT isdefined ('form.payment_method')>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'payment_method')>
	<cfset ErrorMessage = ErrorMessage & '-> Please select a payment method. <br>'>
</cfif>

<cfif isdefined('form.payment_method')>
	<cfif payment_method IS 'ponumber'>
    	<cfinclude template = 'actpocheck.cfm'>
    	<cfif wasPOError IS 'Yes'>
			<cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'ponumber')>
            <cfset ErrorMessage = ErrorMessage & '-> The PO Number you entered is invalid.  Please check the number. <br>'> 
		</cfif>
	</cfif>
</cfif>

<cfif request.checkout_terms IS 'Yes'>
	<cfif NOT isdefined('form.terms')>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'terms')>
	<cfset ErrorMessage = ErrorMessage & '-> You must agree to the Terms and Conditions. <br>'>   
    </cfif>
</cfif>

<cfset URLString = URLString & '&ErrorMessage=#ErrorMessage#&TotalErrors=#TotalErrors#&ErrorList=#ErrorList#'>

<cfif TotalErrors GT 0>
	<cflocation URL = "index.cfm#URLString#">
</cfif>