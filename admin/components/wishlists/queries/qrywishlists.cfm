<cfquery name = "qryWishlists" datasource="#request.dsn#">
SELECT * FROM wishlists
<cfif isdefined('url.id')>WHERE ID = #url.id#</cfif>
</cfquery>
















