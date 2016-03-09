<cfquery name = "qAddGroup" datasource="#request.dsn#">
INSERT INTO nl_groups
(groupname)
VALUES
('#form.groupname#')
</cfquery>

<cflocation url = "index.cfm?action=newsletter.groups.groups&mytoken=#mytoken#">



















