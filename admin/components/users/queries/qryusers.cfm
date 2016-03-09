<cfquery name = "qryusers" datasource = "#request.dsn#">
SELECT * FROM users
<cfif ISDEFINED('url.userid')>WHERE userid=#url.userid#</cfif>
ORDER BY username ASC
</cfquery>















