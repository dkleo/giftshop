<cfquery name = "qryDeleteNewsletter" datasource="#request.dsn#">
DELETE FROM nl_published
WHERE id = #url.id#
</cfquery>

<cflocation url = "index.cfm?action=newsletter.manage.send&mytoken=#mytoken#">



















