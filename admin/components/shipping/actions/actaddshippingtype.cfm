<cfquery name = "AddShippingType" datasource="#request.dsn#">
INSERT INTO ShippingTypes
(ShippingType, AvailableTo)
VALUES
('#form.Shippingtype#', '#form.AvailableTo#')
</cfquery>

<cflocation url = "doshipping.cfm?action=EditShippingTypes&ReturnPath=#url.ReturnPath#">

