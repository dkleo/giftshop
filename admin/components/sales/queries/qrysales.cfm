<cfquery name = "qrySales" datasource="#request.dsn#">
SELECT * FROM sales
<cfif ISDEFINED('url.SaleID')>WHERE SaleID = #url.SaleID#</cfif>
ORDER BY StartDate ASC
</cfquery>

















