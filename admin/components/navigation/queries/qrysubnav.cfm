<cfquery name = "qrySubNav" datasource="#request.dsn#">
SELECT * FROM nav_links WHERE SubLinkOf = '#qryTopNav.id#' AND MenuID = '#mview#'
</cfquery>




















