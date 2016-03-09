<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qAddGroup" datasource="#request.dsn#">
INSERT INTO afl_groups
(groupname)
VALUES
('#form.groupname#')
</cfquery>

<cflocation url = "index.cfm?action=groups.groups">











