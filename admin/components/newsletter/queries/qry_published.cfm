<cfquery name = 'qryPublished' datasource="#request.dsn#">
SELECT * FROM nl_published
<cfif isdefined('url.id')>WHERE id = #url.id#</cfif>
<cfif isdefined('form.id')>WHERE id = #form.id#</cfif>
ORDER BY createdon DESC
</cfquery>




















