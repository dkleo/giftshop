<cfquery name = "qrySubMenus" datasource="#request.dsn#">
SELECT * FROM nav_links
<cfif NOT isdefined('url.linkid')>WHERE SubLinkOf = '#nView#'</cfif>
<cfif isdefined('url.linkid')>WHERE id = #url.linkid#</cfif>
ORDER BY ordervalue ASC
</cfquery>

<!---query to get the master link title--->
<cfquery name = "qryMasterLink" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE id = #nView#
ORDER BY ordervalue ASC
</cfquery>



















