<cfquery name = "qryBrochures" datasource="#request.dsn#">
SELECT * FROM brochures
<cfif isdefined('url.itemID')>WHERE itemid = #url.itemid#</cfif>
</cfquery>















