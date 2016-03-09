<cflock type="exclusive" scope="session" timeout="10">
<cfset session.optionselected = '#form.ShippingType#'>
</cflock>

<cfif NOT isnumeric(form.Amount)>
The Amount field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.amount#</cfoutput>  <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

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

<cfif form.MaxPrice LT '.02'>
The Maximum Price must be at least $.02.  You can't enter a value less than $.02. <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
<cfabort>
</cfif>

<cfif form.MaxPrice LT '.01'>
The Minimum Price must be at least $.01.  You can enter a value of $0.00. <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfquery name = "AddShipping" datasource = '#request.dsn#'>
INSERT INTO shippingtable1
(ShippingType, MinPrice, MaxPrice, Amount)
VALUES
('#form.ShippingType#', '#form.MinPrice#', '#form.MaxPrice#', '#Form.Amount#')
</cfquery>

<cflocation url = "doshipping.cfm?action=EditOne">
