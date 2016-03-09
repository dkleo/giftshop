<cfquery name = "qryCoupons" datasource="#request.dsn#">
SELECT * FROM promos
<cfif ISDEFINED('url.promoid')>WHERE promoid = #url.promoid#</cfif>
</cfquery>



















