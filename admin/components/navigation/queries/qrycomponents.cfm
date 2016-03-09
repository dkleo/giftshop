<cfquery name = "qryComponents" datasource="#request.dsn#">
SELECT * FROM components
<cfif isdefined('form.pluginid')>WHERE id = #form.pluginid#</cfif>
</cfquery>




















