<cfparam name = "sortorder" default="emailaddress">
<cfparam name = "sortby" default="ASC">

<cfquery name = "qryMembers" datasource = "#request.dsn#">
SELECT * FROM nl_members
ORDER BY #SortOrder# #sortby#
</cfquery>

<cfquery name = "qryActiveMembers" datasource = "#request.dsn#">
SELECT * FROM nl_members
WHERE active = 'active'
</cfquery>





















