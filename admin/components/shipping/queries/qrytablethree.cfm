<cfquery name = "qryTableThree" datasource = #request.dsn#>
SELECT *
FROM shippingtable3
<CFIF ISDEFINED('url.ShippingID')>WHERE ShippingID = #url.ShippingID#</CFIF>
<CFIF NOT ISDEFINED('url.ShippingID')></CFIF>
ORDER BY ShippingType ASC, MinWeight ASC
</cfquery>















