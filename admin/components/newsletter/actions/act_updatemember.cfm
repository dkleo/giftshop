<cfquery name = "qryUpdateMember" datasource="#request.dsn#">
UPDATE nl_members
SET name = '#form.name#',
emailaddress = '#form.emailaddress#'
WHERE id = #form.id#
</cfquery>

<cflocation url = "index.cfm?action=newsletter.members.members&mytoken=#mytoken#&updateid=#form.id#">



















