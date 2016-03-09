<cfquery name = "qryBrochures" datasource="#request.dsn#">
SELECT * FROM brochures
<cfif isdefined('url.id')>WHERE id = #url.id#</cfif>
</cfquery>



















