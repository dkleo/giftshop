<cfquery name = "qryTableOne" datasource = #request.dsn#>
SELECT *
FROM shippingtable1
<CFIF ISDEFINED('url.ShippingID')>WHERE ShippingID = #url.ShippingID# </CFIF>
ORDER BY ShippingType ASC, MinPrice ASC
</cfquery>
















