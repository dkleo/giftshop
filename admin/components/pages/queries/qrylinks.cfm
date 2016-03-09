<cfquery name = "qryLinks" datasource="#request.dsn#">
SELECT * FROM links
<cfif ISDEFINED('url.linkid')>WHERE LinkID = #url.LinkID#</cfif>
Order By LinkOrder ASC
</cfquery>
















