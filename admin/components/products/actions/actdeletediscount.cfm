<cfquery name = "qryDeleteDiscount" datasource="#request.dsn#">
DELETE FROM discounts
WHERE discountid = <cfqueryparam value="#url.discountid#" cfsqltype="cf_sql_integer">
</cfquery>

<cflocation url = "doproducts.cfm?action=discounts&itemid=#url.itemid#">















