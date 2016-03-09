<!---Sets the shipping preference--->
<cfquery name = "UpdateShippingMethod" Datasource = #request.dsn#>
UPDATE settings_main
SET ShippingType = '#form.ShippingType#'

</cfquery>


<cfif form.ShippingType IS '2'>
	<cflocation url = "doshipping.cfm?action=EditOne">
</cfif>

<cfif form.ShippingType IS '3'>
	<cflocation url = "doshipping.cfm?action=EditTwo">
</cfif>

<cfif form.ShippingType IS '4'>
	<cflocation url = "doshipping.cfm?action=EditFlat">
</cfif>

<cfif form.ShippingType IS '6'>
	<cflocation url = "doshipping.cfm?action=EditQuantityTable">
</cfif>

<cfif form.ShippingType IS '5'>
	<cflocation url = "doshipping.cfm?action=EditCustom">
</cfif>

<cfif form.ShippingType IS '9'>
	<cflocation url = "doshipping.cfm?action=EditFive">
</cfif>

<cfif form.ShippingType IS '10'>
	<cflocation url = "doshipping.cfm?action=setupUPS">
</cfif>

<cfif form.ShippingType IS '11'>
	<cflocation url = "doshipping.cfm?action=setupFedex">
</cfif>

<p align = "center">Shipping Method Set!</p>


