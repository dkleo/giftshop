<cfset ThisExpiration = #dateformat(form.ExpiresOn, "yyyy-mm-dd")#>

<cfquery name = "AddCoupon" datasource="#request.dsn#">
UPDATE promos
SET PromoCode = '#form.PromoCode#',
ExpiresOn = '#ThisExpiration#', 
CanBeCombined = '#form.CanBeCombined#',
TimesAllowed = #form.TimesAllowed#,
cLimit = #form.cLimit#
WHERE PromoID = #form.PromoID#
</cfquery>

<cflocation url = "index.cfm">




















