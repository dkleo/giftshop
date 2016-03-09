<cfquery name = "qryItemCategories" datasource="#request.dsn#">
SELECT * FROM product_categories
WHERE itemid = #thisitem#
</cfquery>

<cfquery name = "qryItemCategories2" datasource="#request.dsn#">
SELECT category FROM products
WHERE itemid = #thisitem#
</cfquery>
















