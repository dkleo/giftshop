<cfif len(trim(form.po_number)) IS 0>
	You have to at least enter a PO Number
    <cfabort>
</cfif>

<cfset todaysdate = now()>

<cfquery name = "qryInsertPO" datasource="#request.dsn#">
INSERT INTO ponumbers
(dateissued, po_number, companyname, contactname, phone, filenumber, notes)
VALUES
(#createodbcdate(todaysdate)#, '#form.po_number#', '#form.company#', '#form.contactname#', 
'#form.phone#', '#form.filenumber#', '#form.notes#')
</cfquery>

<cflocation url = "index.cfm">















