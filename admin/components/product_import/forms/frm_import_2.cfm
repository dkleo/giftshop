<h2><strong> Product Import Step 2</strong></h2>

<cfif form.importmethod IS 'dsn'>
	<cfinclude template = "frm_import_2dsn.cfm">
</cfif>

<cfif form.importmethod IS 'csv'>
	<cfinclude template = "frm_import_2csv.cfm">
</cfif>















