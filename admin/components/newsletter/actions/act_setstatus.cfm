<!---sets the account as active or inactive...inactive keeps the account info in the db but they won't receive emails--->
<cfif url.status IS 'inactive'>
	<cfset newstatus = 'active'>
<cfelse>
	<cfset newstatus = 'inactive'>
</cfif>

<cfquery name = "qryUpdateStatus" datasource="#request.dsn#">
UPDATE nl_members
SET active = '#newstatus#'
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm?action=newsletter.manage.members&mytoken=#mytoken#">



















