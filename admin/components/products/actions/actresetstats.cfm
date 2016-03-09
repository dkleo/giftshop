<cfquery name="ResetStats" datasource="#request.dsn#">
UPDATE products
SET TimesViewed=0,
UnitsSold=0
WHERE ItemID = #URL.ItemID#
</cfquery>

<cflocation url = "doproducts.cfm?action=ViewStats">















