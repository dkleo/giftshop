<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif len(trim(form.po_number)) IS 0>
	You have to at least enter a PO Number
    <cfabort>
</cfif>

<cfset todaysdate = now()>

<cfquery name = "qryUpdatePO" datasource="#request.dsn#">
UPDATE ponumbers
SET po_number = '#form.po_number#', 
companyname = '#form.company#', 
contactname = '#form.contactname#', 
phone = '#form.phone#', 
filenumber = '#form.filenumber#', 
notes = '#form.notes#'
WHERE id = #form.id#
</cfquery>

<cflocation url = "index.cfm">



















