<cfquery name = "UpdatePromo" datasource = "#application.dsn#">
UPDATE promos
SET PromoCode = '#form.PromoCode#',
PercentOff = '#form.PercentOff#'
WHERE PromoID = #form.PromoID#
</cfquery>

<cflocation url = "dosetup.cfm?action=promos">








