<!---Update a custom shipping option--->

<cfquery name = "UpdateShippingOption" datasource = "#request.dsn#">
UPDATE shippingtable3
SET ShippingType = '#form.ShippingType#',
MinWeight = '#form.MinWeight#',
MaxWeight = '#form.MaxWeight#',
Amount = '#form.Amount#'
WHERE ShippingID = #form.ShippingID#
</cfquery>

<cflocation url = "doshipping.cfm?action=EditCustom">
