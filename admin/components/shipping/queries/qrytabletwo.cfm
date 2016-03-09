<cfquery name = "qryTableTwo" datasource = #request.dsn#>
SELECT *
FROM shippingtable2
<CFIF ISDEFINED('url.ShippingID')>WHERE ShippingID = #url.ShippingID#</CFIF>
ORDER BY ShippingType ASC, MinPrice ASC
</cfquery>















