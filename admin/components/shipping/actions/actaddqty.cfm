<cflock type="exclusive" scope="session" timeout="10">
<cfset session.optionselected = '#form.ShippingType#'>
</cflock>

<cfif NOT isnumeric(form.Amount)>
The Amount field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.amount#</cfoutput>  <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.MinQty)>
The Mininum Weight field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field. The value is currently <cfoutput>#form.MinWeight#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfif NOT isnumeric(form.MaxQty)>
The Maximum Weight field must be a numberic value and cannot contain currency symbols.  Please check that you
provided a numeric value for this field.  The value is currently <cfoutput>#form.MaxWeight#</cfoutput> <a href="javascript:history.go(-1);">Click here to go back</a>.
<cfabort>
</cfif>

<cfquery name = "AddShipping" datasource = '#request.dsn#'>
INSERT INTO shippingtable4
(ShippingType, MinQty, MaxQty, Amount)
VALUES
('#form.ShippingType#', #form.MinQty#, #form.MaxQty#, '#Form.Amount#')
</cfquery>

<cflocation url = "doshipping.cfm?action=EditQuantityTable">
