<cfif NOT isdefined('url.id')>
<cfset WasCreatedOn = Now()>

<cfquery name = "qrySaveNewsletter" datasource="#request.dsn#">
INSERT INTO nl_published 
(Subject, Body, Sent, createdon)
VALUES
('#form.Subject#', '#form.Body#', 'No', #CreateODBCDateTime(WasCreatedOn)#)
</cfquery>
</cfif>

<cfif isdefined('url.id')>
<cfquery name = "updatenewsletter" datasource="#request.dsn#">
UPDATE nl_published
set subject = '#form.subject#',
body = '#form.body#'
WHERE id = #url.id#
</cfquery>
</cfif>

<cflocation url = "index.cfm?action=newsletter.manage.send&mytoken=#mytoken#">



















