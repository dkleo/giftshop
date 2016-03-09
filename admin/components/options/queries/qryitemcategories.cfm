<cfquery name = "qryItemCategories" datasource="#request.dsn#">
SELECT * FROM product_categories
<cfif isdefined('url.itemid')>WHERE itemid = #url.itemid#</cfif>
</cfquery>





















