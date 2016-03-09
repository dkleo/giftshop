<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qApprove" datasource="#request.dsn#">
UPDATE creditapps
SET approved = '#form.approved#',
account_number = '#form.account_number#',
amount = '#form.amount#',
reason = '#form.reason#'
WHERE id = #form.id#
</cfquery>

<cflocation url = "index.cfm?action=approvals">




















