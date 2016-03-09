<!---queries members of a specific group--->
<cfquery name = "qryMembers" datasource="#request.dsn#">
SELECT * FROM nl_members JOIN nl_membersingroup ON nl_membersingroup.memberid = nl_members.id
WHERE nl_membersingroup.groupid = #viewgroup#
</cfquery>