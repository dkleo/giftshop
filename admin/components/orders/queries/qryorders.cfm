<cfparam name = "Sortby" default="DateOfOrder">
<cfparam name = "SortOrder" default = "ASC">
<cfparam name = "paid" default = "Yes">

<CFQUERY Name ="qryOrders" DATASOURCE = "#request.dsn#">
SELECT *
FROM orders
<cfif NOT isdefined('url.OrderID')>WHERE OrderCompleted = 'No' and Paid = '#paid#'</cfif>
<cfif isdefined('url.OrderID')>WHERE OrderID = #url.OrderID#</cfif>
<cfif NOT Sortby IS 'LastName'>
	ORDER BY #SortBy# #SortOrder#
</cfif>
</CFQUERY>

















