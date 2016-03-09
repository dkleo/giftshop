<cfquery name = "qryMember" datasource = "#request.dsn#">
SELECT * FROM nl_members
WHERE id = #url.id#
</cfquery>




















