<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "DeleteTax" datasource="#request.dsn#">
DELETE FROM taxes
WHERE TaxID = #url.TaxID#
</cfquery>
<cflocation url = "dosetup.cfm?action=Taxes">









