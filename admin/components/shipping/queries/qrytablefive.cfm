<cfquery name = "qryTableFive" datasource = #request.dsn#>
SELECT *
FROM shippingtable5
<CFIF ISDEFINED('url.ShippingID')>WHERE ShippingID = #url.ShippingID# </CFIF>
ORDER BY ShippingType ASC, MinPrice ASC
</cfquery>
















