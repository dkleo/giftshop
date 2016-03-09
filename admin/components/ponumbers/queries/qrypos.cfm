<cfquery name = "qryPOs" datasource="#request.dsn#">
SELECT * FROM ponumbers
<cfif isdefined('url.id')>WHERE id = #url.id#</cfif>
</cfquery>















