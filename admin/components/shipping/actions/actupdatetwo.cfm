<!---Update a custom shipping option--->

<cfif NOT isnumeric(form.MinPrice)>
The Mininum Price field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field. The value is currently <cfoutput>#form.MinPrice#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.MaxPrice)>
The Maximum Price field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.MaxPrice#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.Amount) AND NOT form.Amount CONTAINS '%'>
The value you entered for the Percentage is invalid.  The value is currently <cfoutput>#form.amount#</cfoutput> 
You can enter either an decimal value or a number with a percent (%) sign.  <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif form.MaxPrice LT '.02'>
The Maximum Price must be at least $.02.  You can't enter a value less than $.02. <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
<cfabort>
</cfif>

<cfif form.MaxPrice LT '.01'>
The Minimum Price must be at least $.01.  You can enter a value of $0.00. <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfset TheAmount = #form.Amount#>

<cfif form.Amount CONTAINS '%'>
	<cfset TheAmount = replace(#form.Amount#, "%", "", "All")>
	<CFSET TheAmount = #TheAmount# / 100>
</cfif>

<cfquery name = "UpdateShippingOption" datasource = "#request.dsn#">
UPDATE shippingtable2
SET ShippingType = '#form.ShippingType#',
MinPrice = '#form.MinPrice#',
MaxPrice = '#form.MaxPrice#',
Amount = '#TheAmount#'
WHERE ShippingID = #form.ShippingID# 
</cfquery>

<cflocation url = "doshipping.cfm?action=EditTwo">

