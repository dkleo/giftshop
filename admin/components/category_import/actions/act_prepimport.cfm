<!---this file puts all the form data for the import into url variables and then passes it on
	to step 3.  This makes it so the progress bar shows up--->

<cfif form.importmethod IS 'dsn'>
	<cfinclude template = "act_prepimportdsn.cfm">
</cfif>

<cfif form.importmethod IS 'csv'>
	<cfinclude template = "act_prepimportcsv.cfm">
</cfif>




















