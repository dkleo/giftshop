<cfif NOT isdefined('url.id')>
<cfquery name = "qryNavigation" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE SubLinkOf = '#nView#'
ORDER BY ordervalue ASC
</cfquery>
</cfif>

<cfquery name = "qryNavigationAll" datasource="#request.dsn#">
SELECT * FROM nav_links
ORDER BY ordervalue ASC
</cfquery>

<cfif ISDEFINED('url.ID')>
<cfquery name = "qryNavigation" datasource = "#request.dsn#">
SELECT * FROM nav_links
WHERE ID = #url.ID#
</cfquery>
</cfif>



















