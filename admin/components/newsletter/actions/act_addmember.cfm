<cfquery name = "qryAddMember" datasource="#request.dsn#">
INSERT INTO nl_members
(name, emailaddress, <cfif NOT form.groups IS '0'>groups, </cfif>active)
VALUES
('#form.name#', '#form.emailaddress#', <cfif NOT form.groups IS '0'>'#form.groups#', </cfif>'active')
</cfquery>

<cflocation url = "index.cfm?action=newsletter.members.members&mytoken=#mytoken#">



















