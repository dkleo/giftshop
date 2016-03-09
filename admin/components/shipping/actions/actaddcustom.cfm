<cflock type="exclusive" scope="session" timeout="10">
<cfset session.optionselected = '#form.ShippingType#'>
</cflock>

<cfif NOT isnumeric(form.Amount)>
The Amount field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.amount#</cfoutput>  <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.MinWeight)>
The Mininum Weight field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field. The value is currently <cfoutput>#form.MinWeight#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.MaxWeight)>
The Maximum Weight field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.MaxWeight#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfquery name = "AddShipping" datasource = '#request.dsn#'>
INSERT INTO shippingtable3
(ShippingType, MinWeight, MaxWeight, Amount)
VALUES
('#form.ShippingType#', '#form.MinWeight#', '#form.MaxWeight#', '#Form.Amount#')
</cfquery>

<cflocation url = "doshipping.cfm?action=EditCustom">
