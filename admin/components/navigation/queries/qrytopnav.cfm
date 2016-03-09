<cfquery name = "qryTopNav" datasource="#request.dsn#">
SELECT * FROM nav_links WHERE SubLinkOf = '0' AND MenuID = '#mview#'
</cfquery>



















