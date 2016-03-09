<cfquery name = "qryTableFour" datasource = #request.dsn#>
SELECT *
FROM shippingtable4
<cfif ISDEFINED('url.ShippingID')>WHERE ShippingID = #url.ShippingID#</cfif>
ORDER BY ShippingType ASC, MinQty ASC
</cfquery>















