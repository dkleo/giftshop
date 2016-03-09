<cfset ThisExpiration = #dateformat(form.ExpiresOn, "yyyy-mm-dd")#>

<cfquery name = "AddCoupon" datasource="#request.dsn#">
INSERT INTO promos
(PromoCode, AmountOff, ExpiresOn, TimesAllowed, CategoryID, ProductID, PromoType, CanBeCombined, cLimit)
VALUES
('#form.PromoCode#', '#form.AmountOff#', '#ThisExpiration#', #form.TimesAllowed#, '#form.CategoryID#',
'#form.ProductID#', '#form.Promotype#', '#form.CanBeCombined#', #form.cLimit#)
</cfquery>

<cflocation url = "index.cfm">




















