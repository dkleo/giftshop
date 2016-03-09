<!---Update a custom shipping option--->

<cfquery name = "UpdateShippingOption" datasource = "#request.dsn#">
UPDATE shippingtable4
SET ShippingType = '#form.ShippingType#',
MinQty = '#form.MinQty#',
MaxQty = '#form.MaxQty#',
Amount = '#form.Amount#'
WHERE ShippingID = #form.ShippingID#
</cfquery>

<cflocation url = "doshipping.cfm?action=EditQuantityTable">
