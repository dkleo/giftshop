<cfquery name = "DeleteCoupon" datasource="#request.dsn#">
DELETE FROM promos
WHERE PromoID = #url.PromoID#
</cfquery>

<cflocation url = "index.cfm">




















