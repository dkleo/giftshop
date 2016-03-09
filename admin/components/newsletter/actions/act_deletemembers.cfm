<cfif isdefined('form.memberlist')>
<cfloop from = "1" to = "#listlen(form.memberlist)#" index="mycount">
	<cfset membertoremove = #listgetat(form.memberlist, mycount)#>
	
	<cfquery name = "qryDeleteMember" datasource="#request.dsn#">
	DELETE FROM nl_members WHERE id = #membertoremove#
	</cfquery>
	
</cfloop>
</cfif>

<cflocation url = "index.cfm?action=newsletter.manage.members&mytoken=#mytoken#">




















